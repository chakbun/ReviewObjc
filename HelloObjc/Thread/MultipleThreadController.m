//
//  MultipleThreadController.m
//  HelloObjc
//
//  Created by jaben on 2020/3/23.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "MultipleThreadController.h"

@interface MultipleThreadController ()

@end

@implementation MultipleThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testGCD];
}
    
- (void)testGCD {
    
    dispatch_queue_create("xxx", DISPATCH_QUEUE_SERIAL);
    
    dispatch_block_t task = ^ {
        NSLog(@"Thread=> %@ isMain=>%d", [NSThread currentThread], [NSThread isMainThread]);
    };
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        
    });
    
    NSLog(@"============ b4 ============");
    dispatch_main();
    NSLog(@"============ after ============");
}
        

- (void)testBlockOperation {
        NSOperationQueue *que = [[NSOperationQueue alloc] init];
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"============ 1 thread-> %@ ============", [NSThread currentThread]);
        }];


        [operation addExecutionBlock:^{
           NSLog(@"============ 2 thread-> %@ ============", [NSThread currentThread]);
        }];

        [operation addExecutionBlock:^{
           NSLog(@"============ 3 thread-> %@ ============", [NSThread currentThread]);
        }];

        [que addOperation:operation];
}


@end
