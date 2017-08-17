//
//  CoreDataManager.h
//  KUYUTEC
//
//  Created by kuyuZJ on 2017/8/2.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

/**
 上下文
 */
@property(nonatomic,strong,readonly) NSManagedObjectContext* context;

/**
 模型
 */
@property(nonatomic,strong,readonly) NSManagedObjectModel* model;

/**
 持久化
 */
@property(nonatomic,strong,readonly) NSPersistentStoreCoordinator* persistent;

+ (instancetype) shareManager;

- (void)save;

@end
