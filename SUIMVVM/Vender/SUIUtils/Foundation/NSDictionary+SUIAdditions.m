//
//  NSDictionary+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSDictionary+SUIAdditions.h"
#import "SUIMacro.h"

@implementation NSDictionary (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

- (NSString *)sui_toString
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *anyError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&anyError];
        if (anyError) {
            SUILogError(@"dict to string Error ⤭ %@ ⤪", anyError);
            return nil;
        }
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    } else {
        SUILogError(@"dict to string invalid Array ⤭ %@ ⤪", self);
    }
    return nil;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Operate
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Operate

- (BOOL)sui_hasKey:(id)cKey
{
    id curValue = [self objectForKey:cKey];
    if (!kNilOrNull(curValue)) {
        return YES;
    }
    return NO;
}

- (void)sui_each:(void (^)(id _Nonnull, id _Nonnull))cb
{
    if (self.count == 0) return;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        cb(key, obj);
    }];
}

- (void)sui_eachWithStop:(BOOL (^)(id _Nonnull, id _Nonnull))cb
{
    if (self.count == 0) return;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        BOOL toStop = cb(key, obj);
        if (toStop) {
            *stop = YES;
        }
    }];
}

- (instancetype)sui_map:(id  _Nonnull (^)(id _Nonnull, id _Nonnull))cb
{
    if (self.count == 0) return @{};
    NSMutableDictionary *curDict = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self sui_each:^(id  _Nonnull key, id  _Nonnull obj) {
        id returnValue = cb(key, obj);
        if (!kNilOrNull(returnValue)) {
            [curDict setObject:returnValue forKey:key];
        }
    }];    
    return curDict;
}

- (instancetype)sui_pick:(NSArray *)cKeys
{
    if (cKeys.count == 0) return @{};
    NSMutableDictionary *curDict = [NSMutableDictionary dictionary];
    [self sui_each:^(id  _Nonnull key, id  _Nonnull obj) {
        if ([cKeys containsObject:key]) {
            curDict[key] = obj;
        }
    }];
    return curDict;
}

- (instancetype)sui_Omit:(NSArray *)cKeys
{
    if (self.count == 0) return @{};
    NSMutableDictionary *curDict = [NSMutableDictionary dictionary];
    [self sui_each:^(id  _Nonnull key, id  _Nonnull obj) {
        if (![cKeys containsObject:key]) {
            curDict[key] = obj;
        }
    }];
    return curDict;
}

- (instancetype)sui_merge:(NSDictionary *)dictionary
{
    NSMutableDictionary *curDict = [self mutableCopy];
    [curDict addEntriesFromDictionary:dictionary];
    return curDict;
}


@end
