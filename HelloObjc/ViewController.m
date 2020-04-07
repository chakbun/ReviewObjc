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

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) RuntimeTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    
    NSDictionary *map = @{@"name":@"Zach", @"id":@"sn1001", @"age":@30, @"devices":@[@"iPhone", @"iPad", @"macbook pro"]};
    
    BOOL flag = [JRPerferenceManager saveDictionary:map toPlist:@"ZachProfile"];
    
    NSLog(@"============ save result:%@ ============", flag ? @"success" : @"fail");

}


@end
