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
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SEL hello = @selector(helloWithInt:andFloat:);
    NSString *A = ((id (*)(id, SEL, int, float))objc_msgSend)(self, hello, 1,2.2);
    NSLog(@"============ a:%@ ============", A);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

    - (NSString *)helloWithInt:(int)a andFloat:(float)b {
        return [NSString stringWithFormat:@"hello a: %i b:%.2f", a, b];
    }

@end
