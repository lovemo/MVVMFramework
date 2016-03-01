//
//  NSString+SUICrypto.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SUICrypto)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  URL
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - URL

@property (nullable,readonly,copy) NSString *sui_URLEncode;

@property (nullable,readonly,copy) NSString *sui_URLDecode;

- (nullable NSString *)sui_URLEncodeUsingEncoding:(NSStringEncoding)encoding;

- (nullable NSString *)sui_URLDecodeUsingEncoding:(NSStringEncoding)encoding;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Base64
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Base64

@property (nullable,readonly,copy) NSString *sui_base64Encode;

@property (nullable,readonly,copy) NSString *sui_base64Decode;

@property (nullable,readonly,copy) NSData *sui_base64EncodeData;

/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  SHA1 MD5 SHA224 SHA256 SHA384 SHA512
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - SHA1 MD5 SHA224 SHA256 SHA384 SHA512

- (nullable NSString *)sui_md5Digest;

- (nullable NSString *)sui_HMACDigestWithKey:(NSString *)cKey algorithm:(CCHmacAlgorithm)cAlgorithm;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Rc4
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Rc4

- (nullable NSData *)sui_rc4WithKey:(NSString *)cKey;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  AES
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - AES

- (nullable NSString *)sui_AESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv;
- (nullable NSString *)sui_AESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  3DES
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - 3DES

- (nullable NSString *)sui_3DESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv;
- (nullable NSString *)sui_3DESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv;


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSData+SUICrypto
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@interface NSData (SUICrypto)


- (nullable NSData *)sui_AESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv;

- (nullable NSData *)sui_AESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv;

- (nullable NSData *)sui_3DESEncryptWithKey:(NSString *)cKey andIV:(NSData *)iv;

- (nullable NSData *)sui_3DESDecryptWithKey:(NSString *)cKey andIV:(NSData *)iv;


@end

NS_ASSUME_NONNULL_END
