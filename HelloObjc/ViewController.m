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
#import "AVTester.h"
#import "ProtocolManager.h"
#import "KeyCommandProtocol.h"

@interface ViewController ()

@property (nonatomic, strong) AVTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    NSArray *arr = @[@16, @18, @22, @67];
    
    id<KeyCommandProtocol> protcol = [[ProtocolManager shareManager] protocolWithName:@"KeyCommandProtocol"];
    
    float result = [protcol avgInArray:arr];
    
    NSLog(@"============ result : %f ============", result);
}

- (NSString *)valueAtKey:(NSString *)key {
    NSLog(@"============ method invoked ============");
    NSDictionary<NSString *, NSString *> *temp = @{@"name": @"Zach", @"title": @"developer"};
    return temp[key];
}

- (void)invokeTesting {
    SEL targetSelector = NSSelectorFromString(@"valueAtKey:");
    NSMethodSignature *methodSig = [self methodSignatureForSelector:targetSelector];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    invocation.selector = targetSelector;
    NSString *key = @"name";
    [invocation setArgument:&key atIndex:2];
    [invocation invokeWithTarget:self];
    
    if (methodSig.methodReturnLength > 0) {
        NSLog(@" return type = %s", methodSig.methodReturnType);
        NSString *result = nil;
        [invocation getReturnValue:&result];
        if (result) {
            NSLog(@"============ return:%@ ============", result);

        }
    }
}

@end
