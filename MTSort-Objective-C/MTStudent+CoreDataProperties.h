//
//  MTStudent+CoreDataProperties.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSManagedObject *book;

@end

NS_ASSUME_NONNULL_END
