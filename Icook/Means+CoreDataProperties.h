//
//  Means+CoreDataProperties.h
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Means.h"

NS_ASSUME_NONNULL_BEGIN

@interface Means (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *means;
@property (nullable, nonatomic, retain) NSNumber *order;

@end

NS_ASSUME_NONNULL_END
