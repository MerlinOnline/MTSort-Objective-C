//
//  MTCart.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import "MTCart.h"

@implementation MTCart

+(MTCart *)initWithName:(NSString *)name{
    MTCart *car = [[MTCart alloc] init];
    car.name = name;
    return car;
}

@end
