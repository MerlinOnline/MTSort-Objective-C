//
//  MTCart.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCart : NSObject

@property (nonatomic, copy) NSString *name;

+(MTCart *)initWithName:(NSString *)name;

@end
