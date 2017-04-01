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

+ (NSData *)serializeData:(GPBMessage *)message {
    NSString *serialized = [self serialize:message];
    return [serialized dataUsingEncoding:NSUTF8StringEncoding];
}

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

+ (NSString *)serializeBase64:(GPBMessage *)message {
    NSData *serialized = [self serializeData:message];
    return [TKUtil base64EncodeData:serialized];
}

/**
 * Deserializes proto message from JSON string.
 *
 * @param aClass proto message class
 * @param jsonString json string to parse/deserialize
 * @return initialized instance of proto message
 */
+ (id)deserializeMessageOfClass:(Class)aClass fromJSON:(NSString*)jsonString {
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
    
    return  [self deserializeMessageOfClass:aClass fromDictionary:dict];
}

/**
 * Deserializes proto message from Dictionary.
 *
 * @param aClass proto message class
 * @param dictionary disctionary to deserialize from
 * @return initialized instance of proto message
 */
+ (id)deserializeMessageOfClass:(Class)aClass fromDictionary:(NSDictionary*)dictionary {
    id message = [aClass message];
    [self _deserializeMessage:message fromDictionary:dictionary];
    return message;
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
                   format:@"Unsupported field type: %@", [field name]];
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
    NSMutableDictionary<NSString*, NSObject*> *keysToValues = GPBGetMessageMapField(message, field);
    NSMutableDictionary<NSString*, NSObject*> *serializedKeysToValues = [NSMutableDictionary dictionary];
    [keysToValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
        [serializedKeysToValues setValue:[self _serializeValue:obj] forKey:key];
    }];
    return [self sort:serializedKeysToValues];
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
            return [NSString stringWithFormat:@"%lld", GPBGetMessageInt64Field(message, field)];
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

#pragma mark- Deserialization

/**
 * Deserializes GPBMessage object fomm Dictionary created from JSON.
 *
 * @param message message object to deserialize
 * @param dictionary dictionary created form JSON
 * @return
 */
+ (void)_deserializeMessage:(GPBMessage*)message fromDictionary:(NSDictionary*)dictionary {
    GPBDescriptor *descriptor = [message descriptor];
    
    for (GPBFieldDescriptor *field in descriptor.fields) {
        NSString* key = [TKUtil snakeCaseToCamelCase:field.textFormatName];
        id value = [dictionary valueForKey:key];
        if (value) {
            [self _deserializeField:field inMessage:message fromValue:value];
        }
    }
}

/**
 * Deserializes a field in the GPBMessage object from value.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @param value value to deserialize the field from
 * @return
 */
+ (void)_deserializeField:(GPBFieldDescriptor *)field inMessage:(GPBMessage *)message fromValue:(id)value {
    switch (field.fieldType) {
        case GPBFieldTypeRepeated:
            return [self _deserializeRepeated:field inMessage:message fromArray:value];
        case GPBFieldTypeMap:
            return [self _deserializeMap:field inMessage:message fromDictionary:value];
        case GPBFieldTypeSingle:
            return [self _deserializeSingle:field inMessage:message fromValue:value];
        default:
            [NSException
             raise:NSInternalInconsistencyException
             format:@"Unsupported field type: %@", [field name]];
    }
}

/**
 *  Deserializes single field.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @param value value to deserialize the field from
 * @return
 */
+ (void)_deserializeSingle:(GPBFieldDescriptor*)field inMessage:(GPBMessage *)message fromValue:(id)value {
    id valueObject = [self _deserializedObjectForField:field fromValue:value];
    switch (field.dataType) {
        case GPBDataTypeBool:
            GPBSetMessageBoolField(message, field, [valueObject boolValue]);
            break;
        case GPBDataTypeFloat:
            GPBSetMessageFloatField(message, field, [valueObject floatValue]);
            break;
        case GPBDataTypeDouble:
            GPBSetMessageFloatField(message, field, [valueObject doubleValue]);
            break;
        case GPBDataTypeFixed64:
        case GPBDataTypeSFixed64:
        case GPBDataTypeInt64:
        case GPBDataTypeSInt64:
            GPBSetMessageInt64Field(message, field, [valueObject longLongValue]);
            break;
        case GPBDataTypeUInt64:
            GPBSetMessageUInt64Field(message, field, [valueObject unsignedLongLongValue]);
            break;
        case GPBDataTypeFixed32:
        case GPBDataTypeSFixed32:
        case GPBDataTypeInt32:
        case GPBDataTypeSInt32:
            GPBSetMessageInt32Field(message, field, [valueObject intValue]);
            break;
        case GPBDataTypeUInt32:
            GPBSetMessageUInt32Field(message, field, [valueObject unsignedIntValue]);
            break;
        case GPBDataTypeBytes:
            GPBSetMessageBytesField(message, field, valueObject);
            break;
        case GPBDataTypeString:
            GPBSetMessageStringField(message, field, valueObject);
            break;
        case GPBDataTypeEnum:
            GPBSetMessageEnumField(message, field, [valueObject intValue]);
            break;
        case GPBDataTypeMessage:
            GPBSetMessageMessageField(message, field, valueObject);
            break;
        case GPBDataTypeGroup:
        default:
            @throw [NSException
                    exceptionWithName:[NSString stringWithFormat:@"Unsupported field type: %@", field]
                    reason:nil
                    userInfo:nil];
    }
}

/**
 * Helper function to create an object from JSON value that can be set to a message field using 
 * GPBSetMessageXXX method.
 *
 * @param field field descriptor
 * @param value value from JSON
 * @return object that cabe set to the message field
 */
+ (id)_deserializedObjectForField:(GPBFieldDescriptor*)field fromValue:(id)value {
    switch (field.dataType) {
        case GPBDataTypeBool:
            return [NSNumber numberWithBool:[value isEqualToString:@"true"]];
        case GPBDataTypeFixed64:
        case GPBDataTypeSFixed64:
        case GPBDataTypeInt64:
        case GPBDataTypeSInt64:
        case GPBDataTypeUInt64:
            return [NSNumber numberWithLongLong:[value longLongValue]];
        case GPBDataTypeFloat:
        case GPBDataTypeDouble:
        case GPBDataTypeFixed32:
        case GPBDataTypeSFixed32:
        case GPBDataTypeInt32:
        case GPBDataTypeSInt32:
        case GPBDataTypeUInt32:
        case GPBDataTypeString:
            return value;
        case GPBDataTypeBytes:
            return [TKUtil base64DecodeString:value];
        case GPBDataTypeEnum:
        {
            int enumValue;
            [field.enumDescriptor getValue:&enumValue forEnumTextFormatName:value];
            return [NSNumber numberWithInt:enumValue];
        }
        case GPBDataTypeMessage:
        {
            return [self deserializeMessageOfClass:field.msgClass fromDictionary:value];
        }
        case GPBDataTypeGroup:
        default:
            @throw [NSException
                    exceptionWithName:[NSString stringWithFormat:@"Unsupported field type: %@", field]
                    reason:nil
                    userInfo:nil];
    }
}

/**
 *  Deserializes repeated field from an array object.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @param array array to deserialize the field from
 * @return
 */
+ (void)_deserializeRepeated:(GPBFieldDescriptor*)field inMessage:(GPBMessage *)message fromArray:(NSArray*)array {
    if (![array isKindOfClass:[NSArray class]]) {
        [NSException
         raise:NSInternalInconsistencyException
         format:@"Deserializion error: Bad JSON object for repeated field: %@", [field name]];
    }
    id repeatedField = GPBGetMessageRepeatedField(message, field);
    for (id value in array) {
        [self _addValue:value toRepeatedField:repeatedField withDescriptor:field];
    }
}


/**
 * Adds a value to a message repeated field
 *
 * @param value value form JSON
 * @param repeatedField repeated field (either of GPB...Array or NSMutableArray type)
 * @param descriptor field descriptor of the message repeated field
 */
+ (void)_addValue:(id)value toRepeatedField:(id)repeatedField withDescriptor:(GPBFieldDescriptor*)descriptor {
    id valueObject = [self _deserializedObjectForField:descriptor fromValue:value];
    switch (descriptor.dataType) {
        case GPBDataTypeBool:
            [(GPBBoolArray*)repeatedField addValue:[valueObject boolValue]];
            break;
        case GPBDataTypeSFixed32:
        case GPBDataTypeInt32:
        case GPBDataTypeSInt32:
            [(GPBInt32Array*)repeatedField addValue:[valueObject intValue]];
            break;
        case GPBDataTypeFixed32:
        case GPBDataTypeUInt32:
            [(GPBUInt32Array*)repeatedField addValue:[valueObject unsignedIntValue]];
            break;
        case GPBDataTypeSFixed64:
        case GPBDataTypeInt64:
        case GPBDataTypeSInt64:
            [(GPBInt64Array*)repeatedField addValue:[valueObject longLongValue]];
            break;
        case GPBDataTypeFixed64:
        case GPBDataTypeUInt64:
            [(GPBUInt64Array*)repeatedField addValue:[valueObject unsignedLongLongValue]];
            break;
        case GPBDataTypeFloat:
            [(GPBFloatArray*)repeatedField addValue:[valueObject floatValue]];
            break;
        case GPBDataTypeDouble:
            [(GPBDoubleArray*)repeatedField addValue:[valueObject doubleValue]];
            break;
        case GPBDataTypeBytes:
        case GPBDataTypeString:
        case GPBDataTypeMessage:
        case GPBDataTypeGroup:
            [(NSMutableArray*)repeatedField addObject:valueObject];
            break;
        case GPBDataTypeEnum:
            [(GPBEnumArray*)repeatedField addValue:[valueObject intValue]];
            break;
        default:
            [NSException
             raise:NSInternalInconsistencyException
             format:@"Deserializion error: unknown type of repeated field field: %@", [descriptor name]];
    }
}

/**
 *  Deserializes map field from a Dictionary object.
 *
 * @param field field descriptor
 * @param message message containing the field
 * @param array array to deserialize the field from
 * @return
 */
+ (void)_deserializeMap:(GPBFieldDescriptor*)field inMessage:(GPBMessage *)message fromDictionary:(NSDictionary*)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        [NSException
         raise:NSInternalInconsistencyException
         format:@"Deserializion error: Bad JSON object for map field: %@", [field name]];
    }

    NSMutableDictionary* mapDictionary = GPBGetMessageMapField(message, field);
    if (![mapDictionary isKindOfClass:[NSMutableDictionary class]]) {
        [NSException
         raise:NSInternalInconsistencyException
         format:@"Deserializion error: Unsupported key type for map field: %@", [field name]];
    }
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id valueObject = [self _deserializedObjectForField:field fromValue:obj];
        if (![valueObject isKindOfClass:[NSString class]] && ![valueObject isKindOfClass:[GPBMessage class]]) {
            [NSException
             raise:NSInternalInconsistencyException
             format:@"Deserializion error: Unsupported data type for map field: %@", [field name]];
        }
        [mapDictionary setObject:valueObject forKey:key];
    }];
}

@end
