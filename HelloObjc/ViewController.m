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
#import "KVOCTester.h"

@interface ViewController ()<DelegateTester>

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) KVOCTester *tester;

@end

@implementation ViewController
@synthesize delegateName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tester = [KVOCTester new];
    [self.tester kvcTesting];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tester kvoTesting];
}

- (IBAction)testButtonAction:(id)sender {
    [self.tester cleanObserver];
}

#pragma mark - DelegateTester
- (NSInteger)count4Names {
    return 10;
}

@end
