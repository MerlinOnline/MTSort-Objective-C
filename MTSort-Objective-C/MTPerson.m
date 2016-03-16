//
//  MTPerson.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import "MTPerson.h"
#import "MTCart.h"

@implementation MTPerson


//直接实现静态方法，获取带有name和age的Person对象
+(MTPerson *)personWithAge:(int) age withName:(NSString *)name{
    MTPerson *person = [[MTPerson alloc] init];
    person.age = age;
    person.name = name;
    return person;
}

//自定义排序方法
-(NSComparisonResult)comparePerson:(MTPerson *)person{
    //默认按年龄排序
    NSComparisonResult result = [[NSNumber numberWithInt:person.age] compare:[NSNumber numberWithInt:self.age]];//注意:基本数据类型要进行数据转换
    //如果年龄一样，就按照名字排序
    if (result == NSOrderedSame) {
        result = [self.name compare:person.name];
    }
    return result;
}


+(MTPerson *)personWithAge:(int)age withName:(NSString *)name withCar:(MTCart *)car{
    MTPerson *person = [[MTPerson alloc] init];
    person.age = age;
    person.name = name;
    person.car = car;
    return person;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"age is %zi , name is %@, car is %@",_age,_name,_car.name];
}


@end
