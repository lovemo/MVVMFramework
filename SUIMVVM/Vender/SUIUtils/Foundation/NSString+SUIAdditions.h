//
//  NSString+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

@property (nullable,readonly,copy) NSData *sui_toData;
@property (nullable,readonly,copy) NSURL *sui_toURL;
@property (nullable,readonly,copy) NSURLRequest *sui_toURLRequest;
@property (readonly,copy) NSNumber *sui_toNumber;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Formatter
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Formatter

+ (nullable NSString *)sui_stringFromObject:(id)cObject;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Appending
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Appending

- (NSString *)sui_appendingObject:(id)cObject;
- (NSString *)sui_appendingString:(NSString *)cString;
- (NSString *)sui_appendingFormat:(NSString *)cFormat, ... NS_FORMAT_FUNCTION(1,2);


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Contains
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Contains

- (BOOL)sui_containsObject:(id)cObject;
- (BOOL)sui_containsString:(NSString *)cString;
- (BOOL)sui_isNotEmpty;
- (BOOL)sui_containsChinese;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Delstr
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Delstr

- (NSString *)sui_delstrBlankInHeadTail;
- (NSString *)sui_delstrBlankAndWrapInHeadTail;
- (NSString *)sui_delstrStringInHeadTail:(NSString *)cString;
- (NSString *)sui_delstrWrapInHeadTail;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Substr
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Substr

- (NSString *)sui_substrToIndex:(NSUInteger)cIndex;
- (nullable NSString *)sui_substrFromIndex:(NSUInteger)cIndex;
- (nullable NSString *)sui_substrWithRange:(NSRange)cRange;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Replace
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Replace

- (NSString *)sui_replaceString:(NSString *)cString withString:(NSString *)cReplacement;
- (NSString *)sui_replaceString:(NSString *)cString withString:(NSString *)cReplacement options:(NSStringCompareOptions)cOptions;
- (NSString *)sui_replaceRegex:(NSString *)cRegex withString:(NSString *)cReplacement;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Resource
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Resource

- (nullable NSString *)sui_resourceNameCompleteOfType:(nullable NSString *)ext;
- (nullable NSString *)sui_resourcePathForMainBundleOfType:(nullable NSString *)ext;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Size
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Size

- (CGFloat)sui_heightWithFont:(nullable UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sui_sizeWithFont:(nullable UIFont *)font constrainedToWidth:(CGFloat)width;


@end

NS_ASSUME_NONNULL_END
