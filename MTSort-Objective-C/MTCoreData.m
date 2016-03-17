//
//  MTCoreData.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import "MTCoreData.h"

@implementation MTCoreData

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(instancetype)sharedMTCoreData{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}


-(void)showCoreData{
    
    //增
//    [self insertDataToCoreDataWithName:@"阿紫" andWithSex:@"女" forAge:16 forPrice:@"998元"];
    
    //删
//    [self deleteDataWithName:@"张三"];
    
    //查
    [self selectData:20 andOffset:0];
//    [self checkDataToCoreDataWithName:@"张三"];
    
    //改
//    [self updateDataForName:@"张三" withOfSex:@"男" andForAge:90 forPrice:@"9元"];
    
    

}

#pragma mark  插入数据（增）
//插入数据到数据库
-(void)insertDataToCoreDataWithName:(NSString*)name andWithSex:(NSString*)sex forAge:(NSInteger)age forPrice:(NSString*)price{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 传入上下文，创建一个Person实体对象
    NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"MTStudent" inManagedObjectContext:context];
    // 设置Person的简单属性
    [student setValue:name forKey:@"name"];
    [student setValue:[NSNumber numberWithInteger:age] forKey:@"age"];
    [student setValue:sex forKey:@"sex"];
    
    // 传入上下文，创建一个Card实体对象
    NSManagedObject *book = [NSEntityDescription insertNewObjectForEntityForName:@"MTBook" inManagedObjectContext:context];
    [book setValue:price forKey:@"price"];
    // 设置Person和Card之间的关联关系
    [student setValue:book forKey:@"book"];
    
    // 利用上下文对象，将数据同步到持久化存储库
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 如果是想做更新操作：只要在更改了实体对象的属性后调用[context save:&error]，就能将更改的数据同步到数据库

}


#pragma mark  删除数据（删）
//删除数据
-(void)deleteDataWithName:(NSString*)name
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"MTStudent" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    
    // 执行请求
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}



#pragma mark 查询数据（查）
//数据条数数量查询
- (void)selectData:(int)pageSize andOffset:(int)currentPage
{
    NSManagedObjectContext *context = [self managedObjectContext];
    /*
    [request setFetchBatchSize:500];//从数据库里每次加载500条数据来筛选数据
    [request setFetchOffset:sizeCount];//读取数据库的游标偏移量，从游标开始读取数据
    [request setFetchLimit:10];//每次要取多少条数据，10就是每次从数据库读取10条数据
     */
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MTStudent" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (MTStudent *student in fetchedObjects) {
        NSLog(@"name:%@ sex:%@ age:%@ book price:%@",[student valueForKey:@"name"],[student valueForKey:@"sex"],[student valueForKey:@"age"],[student.book valueForKey:@"price"] );
        [resultArray addObject:student];
    }

}

//条件查询
-(void)checkDataToCoreDataWithName:(NSString*)name{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"MTStudent" inManagedObjectContext:context];
    
    // 设置排序（按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    /*
     设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*) "sex like %@", @"*man*" @"sex BEGINSWITH %@", @"man" @"sex = %@", @"man"
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    // 遍历数据
    for (MTStudent *student in objs) {
        NSLog(@"name:%@ sex:%@ age:%@ book price:%@",[student valueForKey:@"name"],[student valueForKey:@"sex"],[student valueForKey:@"age"],[student.book valueForKey:@"price"] );
    }
    
}



#pragma mark 更改数据（改）
//更改数据
- (void)updateDataForName:(NSString*)name  withOfSex:(NSString*)sex andForAge:(NSInteger)age forPrice:(NSString*)price
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"name = %@",name];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"MTStudent" inManagedObjectContext:context]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (MTStudent *student in result) {
        [student setValue:sex forKey:@"sex"];
        [student setValue:[NSNumber numberWithInteger:age] forKey:@"age"];
        [student.book setValue:price forKey:@"price"];
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}


#pragma mark  初始化对象

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSString *docs = [self getDocumentsPathUserID:@"243203681"];
    NSURL *storeURL     = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"MTCoreData.data"]];
    NSLog(@"%@",[docs stringByAppendingPathComponent:@"CMCloudData.data"]);
    
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}



/* 获取Documents文件夹的路径 并且创建DownloadImage文件夹*/
- (NSString *)getDocumentsPathUserID:(NSString*)userID {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    NSString* filePath =[documentsPath stringByAppendingPathComponent:userID];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //新建文件夹
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return filePath;
}




@end
