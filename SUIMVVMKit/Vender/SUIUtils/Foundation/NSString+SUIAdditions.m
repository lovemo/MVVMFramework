//
//  NSString+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSString+SUIAdditions.h"
#import "SUIMacro.h"
#import "NSArray+SUIAdditions.h"
#import "NSDictionary+SUIAdditions.h"
#import "NSString+SUICrypto.h"
#import "NSString+SUIRegex.h"

@implementation NSString (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

- (NSData *)sui_toData
{
    if (self.length == 0) return nil;
    NSData *curData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return curData;
}

- (NSURL *)sui_toURL
{
    if (self.length == 0) return nil;
    NSURL *curURL = [NSURL URLWithString:self];
    if (curURL == nil) {
        curURL = [NSURL URLWithString:[self sui_URLEncode]];
    }
    return curURL;
}

- (NSURLRequest *)sui_toURLRequest
{
    if (self.length == 0) return nil;
    NSURLRequest *curURLRequest = [NSURLRequest requestWithURL:self.sui_toURL];
    return curURLRequest;
}

- (NSNumber *)sui_toNumber
{
    NSNumberFormatter *curFormatter = [[NSNumberFormatter alloc] init];
    [curFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *curNumber = [curFormatter numberFromString:self];
    return curNumber;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Formatter
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Formatter

+ (NSString *)sui_stringFromObject:(id)cObject
{
    NSString *curStr = nil;
    if (kNilOrNull(cObject)) {
        SUILogError(@"Object is nil. This may not be what you want.");
    } else if ([cObject isKindOfClass:[NSString class]]) {
        curStr = cObject;
    } else if ([cObject isKindOfClass:[NSNumber class]]) {
        NSNumber *curNumber = cObject;
        curStr = [curNumber description];
    } else if ([cObject isKindOfClass:[NSURL class]]) {
        NSURL *curURL = cObject;
        curStr = [curURL absoluteString];
    } else if ([cObject isKindOfClass:[NSArray class]]) {
        NSArray *curAry = cObject;
        curStr = [curAry sui_toString];
    } else if ([cObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *curDict = cObject;
        curStr = [curDict sui_toString];
    } else {
        curStr = [cObject description];
    }
    return curStr;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Appending
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Appending

- (NSString *)sui_appendingObject:(id)cObject
{
    NSString *curStr = [NSString sui_stringFromObject:cObject];
    curStr = [self sui_appendingString:curStr];
    return curStr;
}
- (NSString *)sui_appendingString:(NSString *)cString
{
    if (cString.length == 0) return self;
    NSString *curStr = [self stringByAppendingString:cString];
    return curStr;
}
- (NSString *)sui_appendingFormat:(NSString *)cFormat, ...
{
    va_list args;
    va_start(args, cFormat);
    NSString *curStr = [[NSString alloc] initWithFormat:cFormat arguments:args];
    va_end(args);
    curStr = [self sui_appendingString:curStr];
    return curStr;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Contains
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Contains

- (BOOL)sui_containsObject:(id)cObject
{
    NSString *curStr = [NSString sui_stringFromObject:cObject];
    return [self sui_containsString:curStr];
}
- (BOOL)sui_containsString:(NSString *)cString
{
    if (cString.length == 0) return NO;
    
    BOOL isContains = ([self rangeOfString:cString].location != NSNotFound);
    return isContains;
}
- (BOOL)sui_isNotEmpty
{
    if (kNilOrNull(self)) return NO;
    NSString *curStr = [self sui_regex:@"\\S"];
    if (curStr.length == 0) return NO;
    return YES;
}
- (BOOL)sui_containsChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Delstr
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Delstr

- (NSString *)sui_delstrBlankInHeadTail
{
    NSString *curStr = [self sui_delstrStringInHeadTail:@" "];
    return curStr;
}
- (NSString *)sui_delstrBlankAndWrapInHeadTail
{
    NSString *curBlank = @" ";
    NSString *curWrap = @"\n";
    
    NSString *curStr = self;
    while (1) {
        if ([curStr hasPrefix:curBlank]) {
            curStr = [curStr substringFromIndex:curBlank.length];
            continue;
        } else if ([curStr hasSuffix:curBlank]) {
            curStr = [curStr substringToIndex:curStr.length-curBlank.length];
            continue;
        } else if ([curStr hasPrefix:curWrap]) {
            curStr = [curStr substringFromIndex:curWrap.length];
            continue;
        } else if ([curStr hasSuffix:curWrap]) {
            curStr = [curStr substringToIndex:curStr.length-curWrap.length];
            continue;
        } else {
            break;
        }
    }
    return curStr;
}
- (NSString *)sui_delstrStringInHeadTail:(NSString *)cString
{
    if (cString.length == 0) return self;
    NSString *curStr = self;
    while (1) {
        if ([curStr hasPrefix:cString]) {
            curStr = [curStr substringFromIndex:cString.length];
            continue;
        } else if ([curStr hasSuffix:cString]) {
            curStr = [curStr substringToIndex:curStr.length-cString.length];
            continue;
        } else {
            break;
        }
    }
    return curStr;
}
- (NSString *)sui_delstrWrapInHeadTail
{
    NSString *curStr = [self sui_delstrStringInHeadTail:@"\n"];
    return curStr;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Substr
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Substr

- (NSString *)sui_substrToIndex:(NSUInteger)cIndex
{
    if (self.length <= cIndex) {
        SUILogError(@"substrTo Str ⤭ %@ ⤪ length <= Index ⤭ %zd ⤪", self, cIndex);
        return self;
    }
    return [self substringToIndex:cIndex];
}
- (NSString *)sui_substrFromIndex:(NSUInteger)cIndex
{
    if (self.length < cIndex) {
        SUILogError(@"substrFrom Str ⤭ %@ ⤪ length < Index ⤭ %zd ⤪", self, cIndex);
        return nil;
    }
    return [self substringFromIndex:cIndex];
}
- (NSString *)sui_substrWithRange:(NSRange)cRange
{
    if (self.length < cRange.location) {
        SUILogError(@"substrWithRange Str ⤭ %@ ⤪ length < Range ⤭ %@ ⤪", self, NSStringFromRange(cRange));
        return nil;
    } else if (self.length < cRange.location + cRange.length) {
        SUILogError(@"substrWithRange Str ⤭ %@ ⤪ length < Range.location+length ⤭ %@ ⤪", self, NSStringFromRange(cRange));
        return [self sui_substrFromIndex:cRange.location];
    }
    return [self substringWithRange:cRange];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Replace
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Replace

- (NSString *)sui_replaceString:(NSString *)cString withString:(NSString *)cReplacement
{
    if (cString.length == 0) return self;
    NSString *curStr = [self stringByReplacingOccurrencesOfString:cString withString:cReplacement];
    return curStr;
}
- (NSString *)sui_replaceString:(NSString *)cString withString:(NSString *)cReplacement options:(NSStringCompareOptions)cOptions
{
    if (cString.length == 0) return self;
    NSString *curStr = [self stringByReplacingOccurrencesOfString:cString withString:cReplacement options:cOptions range:NSMakeRange(0, self.length)];
    return curStr;
}
- (NSString *)sui_replaceRegex:(NSString *)cRegex withString:(NSString *)cReplacement
{
    if (cRegex.length == 0) return self;
    NSString *curStr = [self stringByReplacingOccurrencesOfString:cRegex withString:cReplacement options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    return curStr;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Resource
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Resource

- (NSString *)sui_resourceNameCompleteOfType:(nullable NSString *)ext
{
    NSString *curName = nil;
    if (ext.length == 0 || [self hasSuffix:ext]) {
        curName = self;
    } else {
        curName = [self stringByAppendingPathExtension:ext];
    }
    return curName;
}
- (NSString *)sui_resourcePathForMainBundleOfType:(nullable NSString *)ext
{
    NSString *curName = [self sui_resourceNameCompleteOfType:ext];
    NSString *curPath = [[NSBundle mainBundle] pathForResource:curName ofType:nil];;
    return curPath;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Size
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Size

- (CGFloat)sui_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGFloat curHeight = [self sui_sizeWithFont:font constrainedToWidth:width].height;
    return curHeight;
}
- (CGSize)sui_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:(NSStringDrawingUsesLineFragmentOrigin)
                                      attributes:attributes
                                         context:nil].size;
    CGSize curSize = CGSizeMake(width, ceil(textSize.height));
    return curSize;
}


@end
