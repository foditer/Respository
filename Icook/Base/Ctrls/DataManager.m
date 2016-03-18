//
//  DataManager.m
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
//单例类创建了Coredata存储数据
@implementation DataManager

+ (instancetype)shareManager
{
    static DataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
        [instance configCoreData];
    });
    
    return instance;
}

- (void)configCoreData {
    
    //1.创建NSManagedObjectModel对象
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //2.创建PSC
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:dataModel];
    
    NSString *dataFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/CoreData.sqlite"];
    
    NSLog(@"%@", dataFilePath);
    NSURL *url = [NSURL fileURLWithPath:dataFilePath];
    
    
    NSDictionary *options = @{
                              //自动版本迁移
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              //自动映射
                              NSInferMappingModelAutomaticallyOption : @YES
                              
                              };
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:nil];
    
    //3.创建Context
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    _context.persistentStoreCoordinator = store;
    
}




@end
