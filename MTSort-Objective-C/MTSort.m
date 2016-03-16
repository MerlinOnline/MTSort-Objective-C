//
//  MTSort.m
//  MTSort-Objective-C
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Bocheng network technology co., LTD. All rights reserved.
//

#import "MTSort.h"
#import "MTPerson.h"
#import "MTCart.h"

@implementation MTSort

//单例
+(instancetype)sharedSort{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}


//展示排序结果
-(void)showSort{
    
    //排序方式一：
    NSMutableArray *data = [[NSMutableArray alloc]initWithObjects:@"7",@"9", @"3",@"5",@"4",@"1",nil];
    [self bubbleSort:data];
    
    [self selectedSort:data];
    
    [self insertSort:data];
    
    [self quickSort:data leftIndex:0 rightIndex:[data count] -1];
    
    //排序方式二:
    
    bubbleSort();
    
    selectSortWithArray();
    
    insertSortWithArray();
    
    [self quickSortWithArray];
    
    //系统自带
    simpleSortArray();
    
    blockSortArray();
    
    sortArray();
    
    sortArray2();
    

    
}

#pragma mark 排序方法一:

//冒泡排序
- (void)bubbleSort:(NSMutableArray *)arr
{
    for (int i = 0; i < arr.count; i++) {
        for (int j = 0; j < arr.count - i - 1;j++) {
            if ([arr[j+1]integerValue] < [arr[j] integerValue]) {
                NSInteger temp = [arr[j] integerValue];
                arr[j] = arr[j + 1];
                arr[j + 1] = [NSNumber numberWithInteger:temp];
            }
        }
    }
    NSLog(@"冒泡排序后：%@",arr);
}

//选择排序
- (void)selectedSort:(NSMutableArray *)arr
{
    for (int i = 0; i < arr.count; i ++) {
        for (int j = i + 1; j < arr.count; j ++) {
            if ([arr[i] integerValue] > [arr[j] integerValue]) {
                NSInteger temp = [arr[i] integerValue];
                arr[i] = arr[j];
                arr[j] = [NSNumber numberWithInteger:temp];
            }
        }
    }
    
    NSLog(@"选择排序后：%@",arr);
}


//插入排序
- (void)insertSort:(NSMutableArray *)arr
{
    for (int i = 1; i < arr.count; i ++) {
        NSInteger temp = [arr[i] integerValue];
        
        for (int j = i - 1; j >= 0 && temp < [arr[j] integerValue]; j --) {
            arr[j + 1] = arr[j];
            arr[j] = [NSNumber numberWithInteger:temp];
        }
        
        
    }
    NSLog(@"插入排序后：%@",arr);
}


//快速排序
- (void)quickSort:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    if (left < right) {
        NSInteger temp = [self getMiddleIndex:arr leftIndex:left rightIndex:right];
        [self quickSort:arr leftIndex:left rightIndex:temp - 1];
        [self quickSort:arr leftIndex:temp + 1 rightIndex:right];
    }
    
     NSLog(@"快速排序后:%@",arr);
}

- (NSInteger)getMiddleIndex:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    NSInteger tempValue = [arr[left] integerValue];
    while (left < right) {
        while (left < right && tempValue <= [arr[right] integerValue]) {
            right --;
        }
        if (left < right) {
            arr[left] = arr[right];
        }
        
        while (left < right && [arr[left] integerValue] <= tempValue) {
            left ++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
    }
    arr[left] = [NSNumber numberWithInteger:tempValue];
    return left;
}



#pragma mark 排序方法二：

//快速排序
-(void)quickSortWithArray{
    NSMutableArray *data = [[NSMutableArray alloc]initWithObjects:@"7",@"9", @"3",@"5",@"4",@"1",nil];
    [self quickSortWithArray:data left:0 right:[data count]-1];
    NSLog(@"快速排序后的结果：%@",[data description]);
}

-(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right{
    if (right > left) {
        NSInteger i = left;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [aData objectAtIndex:++i] < [aData objectAtIndex:left]) ;
            while (j-1 > -1 && [aData objectAtIndex:--j] > [aData objectAtIndex:left]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1];
        [self quickSortWithArray:aData left:j+1 right:right];
    }
}

-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}


//插入排序
void insertSortWithArray(){
    NSMutableArray *data = [[NSMutableArray alloc]initWithObjects:@"7",@"9", @"3",@"5",@"4",@"1",nil];
    for (int i = 1; i < [data count]; i++) {
        id tmp = [data objectAtIndex:i];
        int j = i-1;
        while (j != -1 && [data objectAtIndex:j] > tmp) {
            [data replaceObjectAtIndex:j+1 withObject:[data objectAtIndex:j]];
            j--;
        }
        [data replaceObjectAtIndex:j+1 withObject:tmp];
    }
    NSLog(@"插入排序后的结果：%@",[data description]);
}



//冒泡排序
void bubbleSort(){
    
    NSMutableArray *p = [[NSMutableArray alloc] initWithObjects:@"7",@"9", @"3",@"5",@"4",@"1",nil];
    for (int i = 0; i<[p count]; i++)
    {
        for (int j=i+1; j<[p count]; j++)
        {
            int a = [[p objectAtIndex:i] intValue];
            int b = [[p objectAtIndex:j] intValue];
            
            if (a < b)
            {
                [p replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",b]];
                [p replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%d",a]];
            }
            
        }
        
    }
    
    NSLog(@"排序后:%@",p);


}


//选择排序
void selectSortWithArray(){
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithObjects:@"7",@"9", @"3",@"5",@"4",@"1", nil];
    for (int i=0; i<[data count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[data count]; j++) {
            if ([data objectAtIndex:j] < [data objectAtIndex:m]) {
                m = j;
            }
        }
        if (m != i) {
            NSNumber *tmp = [data objectAtIndex:m];
            [data replaceObjectAtIndex:m withObject:[data objectAtIndex:i]];
            [data replaceObjectAtIndex:i withObject:tmp];
        }
    }
    NSLog(@"选择排序后的结果：%@",[data description]);
    
}


#pragma mark Objective-C 自带排序
//简单排序
void simpleSortArray(){
    NSArray *array = [NSArray arrayWithObjects:@"abc",@"456",@"123",@"789",@"ef", nil];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"排序后:%@",sortedArray);
}

//利用block语法
void blockSortArray(){
    NSArray *array = [NSArray arrayWithObjects:@"1bc",@"4b6",@"123",@"789",@"3ef", nil];
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSLog(@"排序后:%@",sortedArray);
}


#pragma mark  自定义排序
//自定义排序一
void sortArray(){
    MTPerson *p1 = [MTPerson personWithAge:23 withName:@"zhangsan"];
    MTPerson *p2 = [MTPerson personWithAge:21 withName:@"lisi"];
    MTPerson *p3 = [MTPerson personWithAge:24 withName:@"wangwu"];
    MTPerson *p4 = [MTPerson personWithAge:24 withName:@"liwu"];
    MTPerson *p5 = [MTPerson personWithAge:20 withName:@"liwu"];
    NSArray *array = [NSArray arrayWithObjects:p1,p2,p3,p4,p5, nil];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(comparePerson:)];
    
    NSLog(@"排序后:%@",[sortedArray description]);
}


//自定义排序二：高级排序
void sortArray2(){
    //首先来3辆车，分别是奥迪、劳斯莱斯、宝马
    MTCart *car1 = [MTCart initWithName:@"Audio"];
    MTCart *car2 = [MTCart initWithName:@"Rolls-Royce"];
    MTCart *car3 = [MTCart initWithName:@"BMW"];
    
    //再来5个Person，每人送辆车，分别为car2、car1、car1、car3、car2
    MTPerson *p1 = [MTPerson personWithAge:23 withName:@"zhangsan" withCar:car2];
    MTPerson *p2 = [MTPerson personWithAge:21 withName:@"zhangsan" withCar:car1];
    MTPerson *p3 = [MTPerson personWithAge:24 withName:@"lisi" withCar:car1];
    MTPerson *p4 = [MTPerson personWithAge:23 withName:@"wangwu" withCar:car3];
    MTPerson *p5 = [MTPerson personWithAge:23 withName:@"wangwu" withCar:car2];
    
    
    //加入数组
    NSArray *array = [NSArray arrayWithObjects:p1,p2,p3,p4,p5, nil];
    
    //构建排序描述器
    NSSortDescriptor *carNameDesc = [NSSortDescriptor sortDescriptorWithKey:@"car.name" ascending:YES];
    NSSortDescriptor *personNameDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *personAgeDesc = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    
    //把排序描述器放进数组里，放入的顺序就是你想要排序的顺序
    //我这里是：首先按照年龄排序，然后是车的名字，最后是按照人的名字
    NSArray *descriptorArray = [NSArray arrayWithObjects:personAgeDesc,carNameDesc,personNameDesc, nil];
    
    NSArray *sortedArray = [array sortedArrayUsingDescriptors: descriptorArray];
    NSLog(@"%@",sortedArray);
}









@end
