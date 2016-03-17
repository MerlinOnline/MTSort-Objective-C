//
//  MTPerson.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTCart.h"

@interface MTPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) MTCart *car;

+(MTPerson *)personWithAge:(int) age withName:(NSString *)name;
-(NSComparisonResult)comparePerson:(MTPerson *)person;


+(MTPerson *)personWithAge:(int)age withName:(NSString *)name withCar:(MTCart *)car;
-(NSString *)description;

@end
