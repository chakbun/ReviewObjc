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

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) RuntimeTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CoreDataTester *tester = [CoreDataTester new];
    [tester createManagerObjectContext];
    [tester insert];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    
   
}


@end
