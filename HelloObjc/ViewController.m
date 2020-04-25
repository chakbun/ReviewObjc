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

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) NetworkTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tester = [NetworkTester new];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    [self.tester initClientTCPSocketAndConnectServerIP:@"127.0.0.1" port:27323];
}



@end
