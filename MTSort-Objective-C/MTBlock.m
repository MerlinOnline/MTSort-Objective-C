//
//  MTBlock.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import "MTBlock.h"

@interface MTBlock(){

   

}


@end

@implementation MTBlock

+(instancetype)sharedMTBlock{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}


-(void)showYourCode{
    
    showBlockCode();
    
    showSortArray();
    
    showRecurrence();
    
    showUseVariable();
    
}

//简单测试、参数是NSString*的代码块
void showBlockCode(){
    
    int multiplier = 7;
    
    int (^myBlock)(int) = ^(int num){
    
        return num * multiplier;
    };
    
     NSLog(@"%d",myBlock(7));
    
    
    void (^printBlock)(NSString *x);
    printBlock = ^(NSString* str)
    {
        NSLog(@"print:%@", str);
    };
    printBlock(@"hello world!");

}

//代码用在字符串数组排序
void showSortArray(){
    
    NSArray *stringArray = [NSArray arrayWithObjects:@"abc 1", @"abc 21", @"abc 12",@"abc 13",@"abc 05",nil];
    NSComparator sortBlock = ^(id string1, id string2)
    {
        return [string1 compare:string2];
    };
    NSArray *sortArray = [stringArray sortedArrayUsingComparator:sortBlock];
    NSLog(@"sortArray:%@", sortArray);
}

//代码块的递归调用
void showRecurrence(){

    static void (^ const blocks)(int) = ^(int i)
    {
        if (i > 0) {
            NSLog(@"num:%d", i);
            blocks(i - 1);
        }
    };  
    blocks(10);

}



//在代码块中使用局部变量和全局变量、而局部变量可以使用，但是不能改变,否则编译不通过。需要在局部变量前面加上关键字：__block

int global = 1000;

void showUseVariable(){
    
    __block int local = 500;
    
    void(^block)(void) = ^(void)
    {
        global++;
        NSLog(@"global:%d", global);
        
        local++;
        NSLog(@"local:%d", local);
    };
    block();
    NSLog(@"global:%d", global);
    NSLog(@"local:%d", local);

}




@end













