//
//  MTDataSqlite.h
//  MTSort-Objective-C
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MTDataSqlite : NSObject

+(instancetype)sharedMTDataSqlite;

-(void)showDataSqlite;

@end
