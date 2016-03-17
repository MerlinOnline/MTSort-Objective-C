//
//  MTCoreData.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MTStudent.h"
#import "MTBook.h"

@interface MTCoreData : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)sharedMTCoreData;

-(void)showCoreData;

@end
