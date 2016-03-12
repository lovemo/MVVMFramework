//
//  SMKStore.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/24.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "SMKStore.h"
#import "YTKKeyValueStore.h"

@implementation SMKStoreItem

- (NSString *)description {
    return [NSString stringWithFormat:@"id=%@, value=%@, timeStamp=%@", _itemId, _itemObject, _createdTime];
}

@end

@interface SMKStore ()
@property (nonatomic, strong) YTKKeyValueStore *ytk_store;
@end

@implementation SMKStore

static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedStore
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

- (YTKKeyValueStore *)ytk_store {
    if (_ytk_store == nil) {
        _ytk_store = [[YTKKeyValueStore alloc]init];
    }
    return _ytk_store;
}

- (BOOL)db_initDBWithName:(NSString *)dbName {
    return [self.ytk_store initDBWithName:dbName] == nil ? NO : YES;
}

- (BOOL)db_initDBWithPath:(NSString *)dbPath {
    return [self.ytk_store initWithDBWithPath:dbPath] == nil ? NO : YES;
}

- (void)db_createTableWithName:(NSString *)tableName {
    [self.ytk_store createTableWithName:tableName];
}

- (void)db_initWithDBName:(NSString *)dbName tableName:(NSString *)tableName {
    if ([self db_initDBWithName:dbName]) {
        [self.ytk_store createTableWithName:tableName];
    }
}

- (void)db_initWithDBPath:(NSString *)dbPath tableName:(NSString *)tableName {
    if ([self db_initDBWithPath:dbPath]) {
        [self.ytk_store createTableWithName:tableName];
    }
}

- (void)db_clearTable:(NSString *)tableName {
    [self.ytk_store clearTable:tableName];
}

- (BOOL)db_deleteTable:(NSString *)tableName {
    return [self.ytk_store deleteTable:tableName];
}

- (void)db_deleteDatabseWithDBName:(NSString *)DBName {
    [self.ytk_store deleteDatabseWithDBName:DBName];
}

- (void)db_close {
    [self.ytk_store close];
}

- (NSString *)db_getDBPath {
    return [self.ytk_store getDBPath];
}

- (BOOL)db_isExistTableWithName:(NSString *)tableName {
    return [self.ytk_store isExistTableWithName:tableName];
}
///************************ Put&Get methods *****************************************

- (void)db_putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName {
    [self.ytk_store putObject:object withId:objectId intoTable:tableName];
}

- (id)db_getObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    return [self.ytk_store getObjectById:objectId fromTable:tableName];
}

- (SMKStoreItem *)db_getStoreItemById:(NSString *)objectId fromTable:(NSString *)tableName {
    YTKKeyValueItem *item = [self.ytk_store getYTKKeyValueItemById:objectId fromTable:tableName];
    
    SMKStoreItem *storeItem = [[SMKStoreItem alloc]init];
    storeItem.itemId = item.itemId;
    storeItem.itemObject = item.itemObject;
    storeItem.createdTime = item.createdTime;
    
    return storeItem;
}

- (void)db_putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName {
    [self.ytk_store putString:string withId:stringId intoTable:tableName];
}

- (NSString *)db_getStringById:(NSString *)stringId fromTable:(NSString *)tableName {
    return [self.ytk_store getStringById:stringId fromTable:tableName];
}

- (void)db_putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName {
    [self.ytk_store putNumber:number withId:numberId intoTable:tableName];
}

- (NSNumber *)db_getNumberById:(NSString *)numberId fromTable:(NSString *)tableName {
    return [self.ytk_store getNumberById:numberId fromTable:tableName];
}

- (NSArray *)db_getAllItemsFromTable:(NSString *)tableName {
    return [self.ytk_store getAllItemsFromTable:tableName];
}

- (void)db_deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    [self.ytk_store deleteObjectById:objectId fromTable:tableName];
}

- (void)db_deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName {
    [self.ytk_store deleteObjectsByIdArray:objectIdArray fromTable:tableName];
}

- (void)db_deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName {
    [self.ytk_store deleteObjectsByIdPrefix:objectIdPrefix fromTable:tableName];
}

- (NSArray *)db_getItemsFromTable:(NSString *)tableName withRange:(NSRange)range {
    return [self.ytk_store getItemsFromTable:tableName withRange:range];
}

@end
