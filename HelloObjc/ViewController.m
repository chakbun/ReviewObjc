//
//  ViewController.m
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
#import "JRSingleton.h"
#import "MultipleThreadController.h"
#import "RuntimeTester.h"
#import "CopyTester.h"
#import "UIImageView+JRAdditions.h"
#import "UIButton+JRAdditions.h"
#import "JRPerferenceManager.h"
#import "CoreDataTester.h"
#import "Employee.h"
#import "NetworkTester.h"
#import "RunLoopTester.h"

@interface ViewController ()<DelegateTester>

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) RunLoopTester *tester;

@end

@implementation ViewController
@synthesize delegateName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tester = [RunLoopTester new];
    [self.tester addObserverOnMainThread];
    [self.tester addObserverOnNewThread];
    
    sleep(3);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"============ do something on main thread ============");
        CGFloat randomAlpha = (arc4random() % 100)*0.01;
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:randomAlpha]];
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {

}

#pragma mark - DelegateTester
- (NSInteger)count4Names {
    return 10;
}

@end
