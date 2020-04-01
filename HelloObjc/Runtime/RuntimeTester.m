//
//  RuntimeTester.m
//  HelloObjc
//
//  Created by jaben on 2020/3/29.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "RuntimeTester.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "JRSingleton.h"

int cfunction() {
    char *msg = "this is a c function";
    printf("%s", msg);
    return 0;
}

@implementation RuntimeTester

- (void)addMethod {
    //add objc method from other Class
    BOOL result = class_addMethod([RuntimeTester class], NSSelectorFromString(@"printName"), class_getMethodImplementation([JRSingleton class], @selector(printName)), "v@:@");
    
    //add c function
    class_addMethod([RuntimeTester class], NSSelectorFromString(@"printNameII"), (IMP)cfunction, "v@:@");
    
    NSLog(@"============ addmethod result: %@ ============", result ? @"YES":@"NO");
}

- (void)replaceMethod {
    class_replaceMethod([RuntimeTester class], @selector(test), class_getMethodImplementation([RuntimeTester class], @selector(statementWithOutReturn)), "v@:@");
}

- (void)getProperties {
    
    unsigned int pCount;
    objc_property_t *properties = class_copyPropertyList([JRSingleton class], &pCount);
    
    for (int i = 0; i < pCount; i++) {
        objc_property_t t = *properties;
        const char *pName = property_getName(t);
        const char *pAttr = property_getAttributes(t);
        NSLog(@"============ name: %s, att:%s ============", pName, pAttr);
        properties++;
    }
}

- (void)sendMessage2Self {
    ((void (*)(id, SEL))objc_msgSend)(self, @selector(printName));
}

- (void)sendMessage2Nil {
    ((void (*)(id, SEL))objc_msgSend)(nil, @selector(unExistedMethod));
}

- (void)test {
    //invoke method
//    ((void (*)(id, SEL))objc_msgSend)(self, @selector(statementWithOutReturn));
//
//    NSString *result =  ((id (*)(id, SEL, int, NSString *))objc_msgSend)(self, @selector(statementWithReturnAndParametersA:andString:), 10, @"this is a string");
//    NSLog(@"============ result: %@ ============", result);
    
    ((void (*)(id, SEL))objc_msgSend)(self, @selector(printName));
    

}

- (NSString *)statementWithReturnAndParametersA:(int)a andString:(NSString *)b {
    return [NSString stringWithFormat:@"hello a: %i b:%@", a, b];
}

- (void)statementWithOutReturn {
    NSLog(@"============ statementWithOutReturn ============");
}

#pragma mark - Overide
+ (BOOL)resolveInstanceMethod:(SEL)aSel {
    
    NSLog(@"============ resolveInstanceMethod ============");

    if ([NSStringFromSelector(aSel) isEqualToString:@"unExistedMethod"]) {
        //BOOL result = class_addMethod([RuntimeTester class], NSSelectorFromString(@"unExistedMethod"), (IMP)cfunction, "v@:@");
        BOOL result = class_addMethod([RuntimeTester class], NSSelectorFromString(@"unExistedMethod"), class_getMethodImplementation([RuntimeTester class], @selector(statementWithOutReturn)), "v@:@");
        NSLog(@"============ add unExistedMethod : %@ ============", result ? @"YES":@"NO");

        return YES;
    }
    
    return [super resolveInstanceMethod:aSel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"============ forwardingTargetForSelector ============");
    
    if ([NSStringFromSelector(aSelector) isEqualToString:@"unExistedMethodII"]) {
        [self statementWithOutReturn];
        return nil;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [[JRSingleton shareManager] methodSignatureForSelector:aSelector];
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"============ forwardInvocation ============");
    [anInvocation invokeWithTarget:[JRSingleton shareManager]];
    //[super forwardInvocation:anInvocation];
}

@end
