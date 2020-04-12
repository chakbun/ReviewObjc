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

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *name;

@property (nonatomic, strong) CoreDataTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tester = [CoreDataTester new];
    [self.tester createManagerObjectContext];
//    [self.tester addEmployeeName:@"Zach" age:30 sn:@"EM_1001"];
//    [self.tester addEmployeeName:@"Jaben" age:30 sn:@"EM_1002"];
//    [self.tester addEmployeeName:@"Jennifer" age:29 sn:@"EM_1003"];
//    [self.tester addEmployeeName:@"Amazing" age:29 sn:@"EM_1004"];
//    [self.tester addEmployeeName:@"YaQing" age:1 sn:@"EM_1005"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    
    NSArray<Employee *> *result = [self.tester queryEmployeeWithName:nil age:0 sn:nil];
    [result enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"name=%@, age=%i, sn=%@", obj.name, obj.age, obj.sn);
    }];
}


@end
