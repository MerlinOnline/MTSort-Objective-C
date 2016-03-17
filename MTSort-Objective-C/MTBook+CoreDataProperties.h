//
//  MTBook+CoreDataProperties.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTBook (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) MTStudent *student;

@end

NS_ASSUME_NONNULL_END
