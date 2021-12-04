//
//  ViewController.m
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
#import "UIFreezeMonitor.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIFreezeMonitor shareMonitor] start];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"sleep at: %@", [NSDate date]);
    sleep(3);
    NSLog(@"wake up at: %@", [NSDate date]);
}

- (IBAction)testButtonAction:(id)sender {

}

- (NSString *)valueAtKey:(NSString *)key {
    NSLog(@"============ method invoked ============");
    NSDictionary<NSString *, NSString *> *temp = @{@"name": @"Zach", @"title": @"developer"};
    return temp[key];
}


@end
