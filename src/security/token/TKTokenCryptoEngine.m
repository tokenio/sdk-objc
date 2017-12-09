//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

@import LocalAuthentication;

#import "ed25519.h"
#import "TKTokenSecretKey.h"
#import "TKTokenCryptoEngine.h"
#import "TKKeyStore.h"
#import "TKSignature.h"
#import "TKError.h"
#import "TKLocalizer.h"
#import "TKLogManager.h"

@implementation TKTokenCryptoEngine {
    id<TKKeyStore> keyStore;
    BOOL useLocalAuthentication;
    NSString *memberId;
}

- (id)initForMember:(NSString *)memberId_ useKeyStore:(id <TKKeyStore>)store_ useLocalAuthentication:(BOOL)useLocalAuthentication_ {
    self = [super init];

    if (self) {
        keyStore = store_;
        memberId = memberId_;
        useLocalAuthentication = useLocalAuthentication_;
    }

    return self;
}

- (Key *)generateKey:(Key_Level)level {
    TKTokenSecretKey *key = [self createNewKey_:level];
    [keyStore addKey:key forMember:memberId];
    return key.keyInfo;
}

- (Key *)getKeyInfo:(Key_Level)level
             reason:(NSString *)reason
            onError:(OnError)onError {
    TKTokenSecretKey *key = [keyStore lookupKeyByLevel:level forMember:memberId];
    if (!key) {
        onError([NSError errorFromErrorCode:kTKErrorKeyNotFound details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
        return nil;
    }
    return key.keyInfo;
}

- (TKSignature *)signData:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel
                   reason:(NSString *)reason
                  onError:(OnError)onError {
    if (!useLocalAuthentication) {
        return [self createSignature:data usingKeyLevel:keyLevel];
    }
    
    if (keyLevel >= Key_Level_Low) {
        // We don't check DeviceOwnerAuthentication for Key_Level_Low
        return [self createSignature:data usingKeyLevel:keyLevel];
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
        // If device doesn't support Device Owner Authentication, skip as success
        return [self createSignature:data usingKeyLevel:keyLevel];
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block TKSignature *signature = nil;
    __block NSError *laError = nil;
    
    // This method will pop up a modal for passcode or touch ID
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
            localizedReason:reason
                      reply:^(BOOL success, NSError *error) {
                          // This is not the main thread
                          if (success) {
                              signature = [self createSignature:data usingKeyLevel:keyLevel];
                          }
                          else {
                              laError = error;
                          }
                          dispatch_semaphore_signal(semaphore);
                      }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    if (signature == nil) {
        // Handles error
        TKLogError(@"Error signing data: %@", laError);
        if ([laError.domain isEqual:@kLAErrorDomain] &&
            (laError.code == kLAErrorUserCancel || laError.code == kLAErrorSystemCancel )) {
            onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                        details:TKLocalizedString(@"User_Cancelled_Authentication",
                                                                  @"User cancelled authentication")
                              encapsulatedError:laError]);
        }
        else {
            onError([NSError errorFromErrorCode:kTKErrorUserInvalid
                                        details:TKLocalizedString(@"User_Invalid_Authentication",
                                                                  @"Invalid user for authentication")
                              encapsulatedError:laError]);
        }
        return nil;
    }
    
    return signature;
}

- (TKSignature *)createSignature:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel {
    TKTokenSecretKey *key = [keyStore lookupKeyByLevel:keyLevel forMember:memberId];
    unsigned char signature[64];
    unsigned const char *sk = key.privateKey.bytes;
    unsigned const char *pk = key.publicKey.bytes;
    
    ed25519_sign(signature, data.bytes, data.length, pk, sk);
    return [TKSignature
            signature:[TKUtil base64UrlEncodeBytes:(const char *)signature length:sizeof(signature)]
            signedWith:key.keyInfo];
}

- (bool)verifySignature:(NSString *)signature
                forData:(NSData *)data
             usingKeyId:(NSString *)keyId {
    NSData *publicKey = [keyStore lookupKeyById:keyId forMember:memberId].publicKey;
    NSData *decodedSignature = [TKUtil base64UrlDecodeString:signature];
    return ed25519_verify(decodedSignature.bytes, data.bytes, data.length, publicKey.bytes) != 0;
}

#pragma mark private

- (TKTokenSecretKey *)createNewKey_:(Key_Level)keyLevel {
    unsigned char seed[32];
    if (ed25519_create_seed(seed)) {
        [NSException
                raise:NSInternalInconsistencyException
               format:@"Can't initialize random number generator"];
    }

    unsigned char public_key[32], private_key[64];
    ed25519_create_keypair(public_key, private_key, seed);

    NSData *publicKey = [NSData dataWithBytes:public_key length:sizeof(public_key)];
    NSData *privateKey = [NSData dataWithBytes:private_key length:sizeof(private_key)];

    return [TKTokenSecretKey keyWithLevel:keyLevel privateKey:privateKey publicKey:publicKey];
}

@end
