//
//  Material+CoreDataProperties.h
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Material.h"

NS_ASSUME_NONNULL_BEGIN

@interface Material (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *materialName;
@property (nullable, nonatomic, retain) NSString *height;

@end

NS_ASSUME_NONNULL_END
