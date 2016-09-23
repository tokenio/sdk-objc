//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>
#import <Protobuf/GPBDescriptor.h>
#import <Protobuf/GPBUtilities.h>
#import <OrderedDictionary/OrderedDictionary.h>

#import "TKJson.h"
#import "TKUtil.h"


@implementation TKJson

/**
 * Serializes proto message to a JSON string. Some limitations apply. We
 * currently don't handle timestamps, durations and primitive wrapper types
 * the way Google proto library does it (by special casing).
 *
 * @param message message to serialize
 * @return JSON formatted string
 */
+ (NSString *)serialize:(GPBMessage *)message {
    NSDictionary<NSString*, NSObject*> *result = [self _serializeMessage:message];

    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:result options:0 error:&error];

    // The NSJSONSerialization doesn't handle slashes correctly. Ugly hack to fix it...
    // http://stackoverflow.com/questions/15794547/nsjsonserialization-serialization-of-a-string-containing-forward-slashes-and-h
    NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    return [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

#pragma mark private

/**
 * Converts a proto message to a dictionary. The dictionary keys are in the
 * same order in which they are defined in the proto file.
 *
 * @param message proto message
 * @return dictionary
 */
+ (NSDictionary<NSString*, NSObject*> *)_serializeMessage:(GPBMessage *)message {
    GPBDescriptor *descriptor = [message descriptor];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    for (GPBFieldDescriptor *field in descriptor.fields) {
        if (GPBMessageHasFieldSet(message, field) && !field.hasDefaultValue) {
            NSString *key = [TKUtil snakeCaseToCamelCase:field.textFormatName];
            NSObject *value = [self _serialize:field forMessage:message];
            result[key] = value;
        }
    }

    return [self sort:result];
}

/**
 * Serializes a single field.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @return
 */
+ (NSObject *)_serialize:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    switch (field.fieldType) {
        case GPBFieldTypeRepeated:
            return [self _serializeRepeated:field forMessage:message];
        case GPBFieldTypeMap:
            return [self _serializeMap:field forMessage:message];
        case GPBFieldTypeSingle:
            return [self _serializeSingle:field forMessage:message];
        default:
            [NSException
                    raise:NSInternalInconsistencyException
                   format:@"Unsupported field type: %@"
                arguments:field.fieldType];
    }
}

/**
 * Serializes map field.
 *
 * @param field map field descriptor
 * @param message message containing the field
 * @return
 */
+ (NSObject *)_serializeMap:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    NSDictionary<NSObject*, NSString*> *valuesToKeys = GPBGetMessageMapField(message, field);
    NSMutableDictionary<NSString*, NSObject*> *keysToValues = [NSMutableDictionary dictionary];
    for (id value in valuesToKeys) {
        NSString *key = valuesToKeys[value];
        NSObject *serialized = [self _serializeValue:value];
        [keysToValues setObject:serialized forKey:key];
    }
    return [self sort:keysToValues];
}

/**
 * Serializes repeated field.
 *
 * @param field repeated field descriptor
 * @param message message containing the field
 * @return
 */
+ (NSObject *)_serializeRepeated:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    NSArray<NSObject*> *values = GPBGetMessageRepeatedField(message, field);
    NSMutableArray<NSObject*> *serializedValues = [NSMutableArray array];
    for (id value in values) {
        NSObject *o = [self _serializeValue:value];
        [serializedValues addObject:o];
    }
    return serializedValues;
}

/**
 * Serializes single field.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @return
 */
+ (NSObject *)_serializeSingle:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    switch (field.dataType) {
        case GPBDataTypeBool:
            return GPBGetMessageBoolField(message, field) == TRUE ? @"true" : @"false";
        case GPBDataTypeFloat:
            return @(GPBGetMessageFloatField(message, field));
        case GPBDataTypeDouble:
            return @(GPBGetMessageDoubleField(message, field));
        case GPBDataTypeFixed64:
        case GPBDataTypeSFixed64:
        case GPBDataTypeInt64:
        case GPBDataTypeSInt64:
            return @(GPBGetMessageInt64Field(message, field));
        case GPBDataTypeUInt64:
            return @(GPBGetMessageUInt64Field(message, field));
        case GPBDataTypeFixed32:
        case GPBDataTypeSFixed32:
        case GPBDataTypeInt32:
        case GPBDataTypeSInt32:
            return @(GPBGetMessageInt32Field(message, field));
        case GPBDataTypeUInt32:
            return @(GPBGetMessageUInt32Field(message, field));
        case GPBDataTypeBytes:
            return [TKUtil base64EncodeData:GPBGetMessageBytesField(message, field) padding:true];
        case GPBDataTypeString:
            return GPBGetMessageStringField(message, field);
        case GPBDataTypeEnum:
            return [field.enumDescriptor textFormatNameForValue:GPBGetMessageEnumField(message, field)];
        case GPBDataTypeMessage:
            return [self _serializeMessage:GPBGetMessageMessageField(message, field)];
        case GPBDataTypeGroup:
        default:
            @throw [NSException
                    exceptionWithName:[NSString stringWithFormat:@"Unsupported field type: %@", field]
                               reason:nil
                             userInfo:nil];
    }
}

/**
 * Serializes a value. The value is expected to either be a proto message or
 * of a primitive type.
 *
 * @param object object to serialize
 * @return
 */
+ (NSObject *)_serializeValue:(NSObject *)object {
    if ([object isKindOfClass:[GPBMessage class]]) {
        return [self _serializeMessage:(GPBMessage *) object];
    } else {
        return object;
    }
}

+ (OrderedDictionary<NSString*, NSObject*> *)sort:(NSDictionary *)dictionary  {
    NSArray *sortedKeys = [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];

    MutableOrderedDictionary<NSString*, NSObject*> *result = [MutableOrderedDictionary dictionary];
    for (id key in sortedKeys) {
        [result setObject:dictionary[key] forKey:key];
    }
    return result;
}

@end