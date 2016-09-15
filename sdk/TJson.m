//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TJson.h"
#import "GPBMessage.h"
#import "GPBDescriptor.h"
#import "GPBUtilities.h"
#import "OrderedDictionary.h"
#import "TUtil.h"


@interface Value : NSObject
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSObject *value;
@end

@implementation Value
@end

@implementation TJson

/**
 * Serializes proto message to a JSON string. Some limitations apply. We
 * currently don't handle timestamps, durations and primitive wrapper types
 * the way Google proto library does it (by special casing).
 *
 * @param message message to serialize
 * @return JSON formatted string
 */
+ (NSString *)serialize:(GPBMessage *)message {
    NSDictionary *result = [self serializeMessage:message];

    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:result options:0 error:&error];
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

/**
 * Converts a proto message to a dictionary. The dictionary keys are in the
 * same order in which they are defined in the proto file.
 *
 * @param message proto message
 * @return dictionary
 */
+ (NSDictionary *)serializeMessage:(GPBMessage *)message {
    GPBDescriptor *descriptor = [message descriptor];
    MutableOrderedDictionary *result = [MutableOrderedDictionary dictionary];

    for (GPBFieldDescriptor *field in descriptor.fields) {
        if (GPBMessageHasFieldSet(message, field) && !field.hasDefaultValue) {
            Value *value = [self serialize:field forMessage:message];
            result[value.key] = value.value;
        }
    }

    return result;
}

/**
 * Serializes a single field.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @return
 */
+ (Value *)serialize:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    switch (field.fieldType) {
        case GPBFieldTypeRepeated:
            return [self serializeRepeated:field forMessage:message];
        case GPBFieldTypeMap:
            return [self serializeMap:field forMessage:message];
        case GPBFieldTypeSingle:
            return [self serializeSingle:field forMessage:message];
        default:
            [NSException
                    raise:NSInternalInconsistencyException
                   format:@"Unsupported field type"
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
+ (Value *)serializeMap:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    NSDictionary *valuesToKeys = GPBGetMessageMapField(message, field);

    MutableOrderedDictionary *keysToValues = [MutableOrderedDictionary dictionary];
    for (id value in valuesToKeys) {
        NSString *key = valuesToKeys[value];
        NSObject *serialized = [self serializeValue:value];
        [keysToValues setObject:serialized forKey:key];
    }

    Value *result = [[Value alloc] init];
    result.key = field.name;
    result.value = keysToValues;

    return result;
}

/**
 * Serializes repeated field.
 *
 * @param field repeated field descriptor
 * @param message message containing the field
 * @return
 */
+ (Value *)serializeRepeated:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    NSString *suffix = @"Array";

    NSArray *values = GPBGetMessageRepeatedField(message, field);
    NSMutableArray *serializedValues = [NSMutableArray array];
    for (id value in values) {
        NSObject *o = [self serializeValue:value];
        [serializedValues addObject:o];
    }

    Value *result = [[Value alloc] init];
    result.key = [field.name substringWithRange:NSMakeRange(0, field.name.length - suffix.length)];
    result.value = serializedValues;

    return result;
}

/**
 * Serializes single field.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @return
 */
+ (Value *)serializeSingle:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
    Value *value = [[Value alloc] init];
    value.key = field.name;
    value.value = [self toObject:field forMessage:message];
    return value;
}

/**
 * Serializes a value. The value is expected to either be a proto message or
 * of a primitive type.
 *
 * @param object object to serialize
 * @return
 */
+ (NSObject *)serializeValue:(NSObject *)object {
    if ([object isKindOfClass:[GPBMessage class]]) {
        return [self serializeMessage:(GPBMessage *) object];
    } else {
        return object;
    }
}

/**
 * Converts specified field into object.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @return
 */
+ (NSObject *)toObject:(GPBFieldDescriptor *)field forMessage:(GPBMessage *)message {
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
            return [TUtil base64EncodeData:GPBGetMessageBytesField(message, field)];
        case GPBDataTypeString:
            return GPBGetMessageStringField(message, field);
        case GPBDataTypeEnum:
            return [field.enumDescriptor textFormatNameForValue:GPBGetMessageEnumField(message, field)];
        case GPBDataTypeMessage:
            return [self serializeMessage:GPBGetMessageMessageField(message, field)];
        case GPBDataTypeGroup:
        default:
            @throw [NSException
                    exceptionWithName:[NSString stringWithFormat:@"Unsupported field type: %@", field]
                               reason:nil
                             userInfo:nil];
    }
}

@end