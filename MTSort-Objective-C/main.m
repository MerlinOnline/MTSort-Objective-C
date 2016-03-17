//
//  main.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTSort.h"
#import "MTBlock.h"
#import "MTSqlite.h"
#import "MTCoreData.h"

int main(int argc, const char * argv[]) {
    
    
    @autoreleasepool {
        // insert code here...
        
        
        //排序展示
//        [[MTSort sharedSort] showSort];
        
        
//        [[MTBlock sharedMTBlock] showYourCode];
        
//        [[MTSqlite sharedMTSqlite] showSqlite];
        
        [[MTCoreData sharedMTCoreData] showCoreData];
        
        
    }
    return 0;
}


