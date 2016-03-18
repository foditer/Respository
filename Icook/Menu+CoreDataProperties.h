//
//  Menu+CoreDataProperties.h
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Menu.h"

NS_ASSUME_NONNULL_BEGIN

@interface Menu (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *suggest;
@property (nullable, nonatomic, retain) NSString *synopsis;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *menu_means;
@property (nullable, nonatomic, retain) Material *menu_material;

@end

@interface Menu (CoreDataGeneratedAccessors)

- (void)addMenu_meansObject:(NSManagedObject *)value;
- (void)removeMenu_meansObject:(NSManagedObject *)value;
- (void)addMenu_means:(NSSet<NSManagedObject *> *)values;
- (void)removeMenu_means:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
