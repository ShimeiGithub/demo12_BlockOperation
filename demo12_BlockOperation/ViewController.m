//
//  ViewController.m
//  demo12_BlockOperation
//
//  Created by LuoShimei on 16/5/14.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//
/**
 NSOperationQueue只有两种队列
 1.主队列 同步串行
 2.自定义队列 异步并行
 
 执行方式：
 1. 同步 (主线程) 
    [operation start];
 2. 异步执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    将上面的操作放到队列中 (添加的那一瞬间异步执行)
    [queue addOperation:operation];
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 关联的方法
/** 同步串行 */
- (IBAction)blockSync:(id)sender {
    //1.创建操作
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    //2.向操作中添加block任务
    [operation addExecutionBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockSync下载图片1 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    [operation addExecutionBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockSync下载图片2 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    [operation addExecutionBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockSync下载图片3 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    //3.创建主队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //4.将block任务操作放入到主队列中
    [mainQueue addOperation:operation];
}


/** 异步并行 */
- (IBAction)blockAsync:(id)sender {
    //1.创建操作
    NSBlockOperation *operation0 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockAsync下载图片1 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockAsync下载图片2 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"blockAsync下载图片3 i = %d,current thread = %@", i,[NSThread currentThread]);
            //让线程小睡一下
            sleep(1);
        }
    }];
    
    //2.创建自定义的队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //3.向队列总添加block操作任务
    [queue addOperations:@[operation0,operation1,operation2] waitUntilFinished:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  
 输出结果：
 2016-05-14 23:38:26.972 demo12_BlockOperation[26688:942194] blockSync下载图片1 i = 0,current thread = <NSThread: 0x7fc13a0040b0>{number = 1, name = main}
 2016-05-14 23:38:26.972 demo12_BlockOperation[26688:942337] blockSync下载图片2 i = 0,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:26.972 demo12_BlockOperation[26688:942327] blockSync下载图片3 i = 0,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:27.974 demo12_BlockOperation[26688:942194] blockSync下载图片1 i = 1,current thread = <NSThread: 0x7fc13a0040b0>{number = 1, name = main}
 2016-05-14 23:38:28.035 demo12_BlockOperation[26688:942337] blockSync下载图片2 i = 1,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:28.035 demo12_BlockOperation[26688:942327] blockSync下载图片3 i = 1,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:28.976 demo12_BlockOperation[26688:942194] blockSync下载图片1 i = 2,current thread = <NSThread: 0x7fc13a0040b0>{number = 1, name = main}
 2016-05-14 23:38:29.104 demo12_BlockOperation[26688:942337] blockSync下载图片2 i = 2,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:29.104 demo12_BlockOperation[26688:942327] blockSync下载图片3 i = 2,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:29.977 demo12_BlockOperation[26688:942194] blockSync下载图片1 i = 3,current thread = <NSThread: 0x7fc13a0040b0>{number = 1, name = main}
 2016-05-14 23:38:30.179 demo12_BlockOperation[26688:942337] blockSync下载图片2 i = 3,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:30.179 demo12_BlockOperation[26688:942327] blockSync下载图片3 i = 3,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:30.979 demo12_BlockOperation[26688:942194] blockSync下载图片1 i = 4,current thread = <NSThread: 0x7fc13a0040b0>{number = 1, name = main}
 2016-05-14 23:38:31.253 demo12_BlockOperation[26688:942327] blockSync下载图片3 i = 4,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:31.253 demo12_BlockOperation[26688:942337] blockSync下载图片2 i = 4,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:38.052 demo12_BlockOperation[26688:942337] blockAsync下载图片1 i = 0,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:38.052 demo12_BlockOperation[26688:942327] blockAsync下载图片2 i = 0,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:38.052 demo12_BlockOperation[26688:943481] blockAsync下载图片3 i = 0,current thread = <NSThread: 0x7fc13870e300>{number = 4, name = (null)}
 2016-05-14 23:38:39.119 demo12_BlockOperation[26688:943481] blockAsync下载图片3 i = 1,current thread = <NSThread: 0x7fc13870e300>{number = 4, name = (null)}
 2016-05-14 23:38:39.119 demo12_BlockOperation[26688:942337] blockAsync下载图片1 i = 1,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:39.119 demo12_BlockOperation[26688:942327] blockAsync下载图片2 i = 1,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:40.188 demo12_BlockOperation[26688:942337] blockAsync下载图片1 i = 2,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:40.188 demo12_BlockOperation[26688:943481] blockAsync下载图片3 i = 2,current thread = <NSThread: 0x7fc13870e300>{number = 4, name = (null)}
 2016-05-14 23:38:40.188 demo12_BlockOperation[26688:942327] blockAsync下载图片2 i = 2,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:41.262 demo12_BlockOperation[26688:942327] blockAsync下载图片2 i = 3,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:41.262 demo12_BlockOperation[26688:942337] blockAsync下载图片1 i = 3,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:41.262 demo12_BlockOperation[26688:943481] blockAsync下载图片3 i = 3,current thread = <NSThread: 0x7fc13870e300>{number = 4, name = (null)}
 2016-05-14 23:38:42.329 demo12_BlockOperation[26688:942327] blockAsync下载图片2 i = 4,current thread = <NSThread: 0x7fc138523810>{number = 2, name = (null)}
 2016-05-14 23:38:42.329 demo12_BlockOperation[26688:942337] blockAsync下载图片1 i = 4,current thread = <NSThread: 0x7fc1387890e0>{number = 3, name = (null)}
 2016-05-14 23:38:42.329 demo12_BlockOperation[26688:943481] blockAsync下载图片3 i = 4,current thread = <NSThread: 0x7fc13870e300>{number = 4, name = (null)}
 */

@end
