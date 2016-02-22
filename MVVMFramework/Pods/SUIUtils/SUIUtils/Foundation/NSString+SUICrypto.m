//
//  NSString+SUICrypto.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSString+SUICrypto.h"
#import "SUIMacro.h"
#import "NSString+SUIAdditions.h"
#import "NSData+SUIAdditions.h"

@implementation NSString (SUICrypto)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  URL
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - URL

- (NSString *)sui_URLEncode
{
    return [self sui_URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)sui_URLDecode
{
    return [self sui_URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)sui_URLEncodeUsingEncoding:(NSStringEncoding)encoding
{
    if (self.length == 0) return nil;
    NSData *curData = [self dataUsingEncoding:encoding];
    NSString *curStr = [curData base64EncodedStringWithOptions:0];
    return curStr;
}

- (NSString *)sui_URLDecodeUsingEncoding:(NSStringEncoding)encoding
{
    if (self.length == 0) return nil;
    NSData *curData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *curStr = [[NSString alloc] initWithData:curData encoding:encoding];
    return curStr;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Base64
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Base64

- (NSString *)sui_base64Encode
{
    if (self.length == 0) return nil;
    NSData *curData = [self sui_toData];
    NSString *curStr = [curData base64EncodedStringWithOptions:0];
    return curStr;
}

- (NSString *)sui_base64Decode
{
    if (self.length == 0) return nil;
    NSData *curData = self.sui_base64EncodeData;
    NSString *curStr = curData.sui_toUTF8String;
    return curStr;
}

- (NSData *)sui_base64EncodeData
{
    if (self.length == 0) return nil;
    NSData *curData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return curData;
}

/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  SHA1 MD5 SHA224 SHA256 SHA384 SHA512
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - SHA1 MD5 SHA224 SHA256 SHA384 SHA512

+ (NSString *)sui_stringFromDigest:(uint8_t *)cDigest length:(int)cLength
{
    NSMutableString *curHash = [[NSMutableString alloc] initWithCapacity:cLength * 2];
    for (int idx=0; idx<cLength; idx++) {
        [curHash appendFormat:@"%02x", (int)cDigest[idx]];
    }
    return [curHash copy];
}

- (NSString *)sui_md5Digest
{
    if (self.length == 0) return nil;
    NSData *curData = [self sui_toData];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(curData.bytes, (CC_LONG)curData.length, digest);
    NSString *curStr = [NSString sui_stringFromDigest:digest length:CC_MD5_DIGEST_LENGTH];
    return curStr;
}
- (NSString *)sui_HMACDigestWithKey:(NSString *)cKey algorithm:(CCHmacAlgorithm)cAlgorithm
{
    if (cKey.length == 0 || self.length == 0) return nil;
    const char *curKey = [cKey cStringUsingEncoding:NSASCIIStringEncoding];
    const char *curData = [self cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSUInteger length = 0;
    switch (cAlgorithm) {
        case kCCHmacAlgSHA1:
            length = CC_SHA1_DIGEST_LENGTH;
            break;
        case kCCHmacAlgMD5:
            length = CC_MD5_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA224:
            length = CC_SHA224_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA256:
            length = CC_SHA256_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA384:
            length = CC_SHA384_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA512:
            length = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            SUILogError(@"This should not occur");
            break;
    }
    
    if (length == 0) return nil;
    
    unsigned char *digest = malloc(length);
    CCHmac(cAlgorithm, curKey, strlen(curKey), curData, strlen(curData), digest);
    
    NSMutableString *curString = [[NSMutableString alloc] initWithCapacity:length * 2];
    for (NSUInteger i = 0; i < length; i++) {
        [curString appendFormat:@"%02lx", (unsigned long)digest[i]];
    }
    
    free(digest);
    return curString;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Rc4
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Rc4

- (NSData *)sui_rc4WithKey:(NSString *)cKey
{
    if (self.length == 0) return nil;
    
    const char *ut8String = [self UTF8String];
    size_t len = strlen(ut8String);
    int j = 0;
    unsigned char s[256];
    unsigned char result[len];
    for (int i = 0; i < 256; i++)
    {
        s[i] = i;
    }
    for (int i = 0; i < 256; i++)
    {
        j = (j + s[i] + [cKey characterAtIndex:(i % cKey.length)]) % 256;
        swap(&s[i], &s[j]);
    }
    
    int i = j = 0;
    
    for (int y = 0; y < len; y++)
    {
        i = (i + 1) % 256;
        j = (j + s[i]) % 256;
        swap(&s[i], &s[j]);
        
        unsigned char f = ut8String[y] ^ s[ (s[i] + s[j]) % 256];
        result[y]=f;
    }
    
    NSData *curData = [NSData dataWithBytes:result length:sizeof(unsigned char)*len];
    return curData;
}

void swap(unsigned char *first, unsigned char *second)
{
    unsigned char tempVar; // make a temporary variable
    tempVar = *first;
    *first = *second;
    *second=tempVar;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  AES
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - AES

- (nullable NSString *)sui_AESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    if (self.length == 0) return nil;
    NSData *encrypted = [[self sui_toData] sui_AESEncryptWithKey:cKey andIV:iv];
    NSString *encryptedString = [encrypted sui_base64Encode];
    return encryptedString;
}

- (nullable NSString *)sui_AESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    if (self.length == 0) return nil;
    NSData *decrypted = [self.sui_base64EncodeData sui_AESDecryptWithKey:cKey andIV:iv];
    NSString *decryptedString = decrypted.sui_toUTF8String;
    return decryptedString;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  3DES
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - 3DES

- (nullable NSString *)sui_3DESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    if (self.length == 0) return nil;
    NSData *encrypted = [self.sui_toData sui_3DESEncryptWithKey:cKey andIV:iv];
    NSString *encryptedString = [encrypted sui_base64Encode];
    return encryptedString;
}

- (nullable NSString *)sui_3DESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    if (self.length == 0) return nil;
    NSData *decrypted = [self.sui_toData sui_3DESDecryptWithKey:cKey andIV:iv];
    NSString *decryptedString = decrypted.sui_toUTF8String;
    return decryptedString;
}


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSData+SUICrypto
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation NSData (SUICrypto)


- (nullable NSData *)sui_AESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    NSData *keyData = [cKey sui_toData];
    
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    
    return nil;
}

- (nullable NSData *)sui_AESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    NSData *keyData = [cKey sui_toData];
    
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    
    return nil;
}

- (nullable NSData *)sui_3DESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    NSData *keyData = [cKey sui_toData];
    
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    
    return nil;
}

- (nullable NSData *)sui_3DESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv
{
    NSData *keyData = [cKey sui_toData];
    
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    
    return nil;
}


@end
