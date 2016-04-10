//
//  SMKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMKStoreItem : NSObject

@property (strong, nonatomic) NSString *smk_itemId;
@property (strong, nonatomic) id smk_itemObject;
@property (strong, nonatomic) NSDate *smk_createdTime;

@end


@interface SMKStore : NSObject

/**
 *  根据dbName初始化数据库
 */
- (id)initDBWithName:(NSString *)dbName;

/**
 *  根据dbPath初始化数据库
 */
- (id)initWithDBWithPath:(NSString *)dbPath;

/**
 *  根据tableName创建数据表
 */
- (void)smk_createTableWithName:(NSString *)tableName;

/**
 *  清空数据表
 */
- (void)smk_clearTable:(NSString *)tableName;

/**
 *  tableName是否存在
 */
- (BOOL)smk_isExistTableWithName:(NSString *)tableName;

/**
 *  删除表
 */
- (BOOL)smk_deleteTable:(NSString *)tableName;

/**
 *  删除数据库
 */
- (void)smk_deleteDatabseWithDBName:(NSString *)DBName;

/**
 *  获得数据库存储路径
 */
- (NSString *)smk_getDBPath;

/**
 *  关闭数据库
 */
- (void)smk_close;

///************************ Put&Get methods *****************************************

- (void)smk_putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

- (id)smk_getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

- (SMKStoreItem *)smk_getSMKStoreItemById:(NSString *)objectId fromTable:(NSString *)tableName;

- (void)smk_putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

- (NSString *)smk_getStringById:(NSString *)stringId fromTable:(NSString *)tableName;

- (void)smk_putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

- (NSNumber *)smk_getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;

- (NSArray *)smk_getAllItemsFromTable:(NSString *)tableName;

- (void)smk_deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

- (void)smk_deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

- (void)smk_deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;

- (NSArray *)smk_getItemsFromTable:(NSString *)tableName withRange:(NSRange)range;

@end
