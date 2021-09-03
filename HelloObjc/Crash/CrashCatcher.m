//
//  CrashCatcher.m
//  HelloObjc
//
//  Created by edz on 2021/9/2.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "CrashCatcher.h"
#import <libkern/OSAtomic.h>

void UncaughtExceptionHandler(NSException * exception) {
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    NSLog(@"crash exception:\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]);
}

void UncaughtSinal(int sig) {
    NSLog(@"crash signal:%i", sig);
}

static void SASignalHandler(int crashSignal, struct __siginfo *info, void *context) {
    
    static volatile int32_t UncaughtExceptionCount = 0;
    static const int32_t UncaughtExceptionMaximum = 10;
    
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount <= UncaughtExceptionMaximum) {
        NSDictionary *userInfo = @{@"UncaughtExceptionHandlerSignalKey": @(crashSignal)};
        NSString *reason;
        @try {
            reason = [NSString stringWithFormat:@"Signal %d was raised.", crashSignal];
        } @catch(NSException *exception) {
            //ignored
        }

        @try {
            NSException *exception = [NSException exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
                                                             reason:reason
                                                           userInfo:userInfo];
            NSLog(@"---> ", exception);
        } @catch(NSException *exception) {

        }
    }
}


@implementation CrashCatcher

+ (instancetype)shareInstance {
    static CrashCatcher *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CrashCatcher alloc] init];
        [instance setDefaultHandler];
    });
    return instance;
}

- (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    
    struct sigaction action;
    sigemptyset(&action.sa_mask);
    action.sa_flags = SA_SIGINFO;
    action.sa_sigaction = &SASignalHandler;
    int signals[] = {SIGABRT, SIGILL, SIGSEGV, SIGFPE, SIGBUS};
    for (int i = 0; i < sizeof(signals) / sizeof(int); i++) {
        struct sigaction prev_action;
        int err = sigaction(signals[i], &action, &prev_action);
//        signal(signals[i], &UncaughtSinal);
        NSLog(@"sigaction err = %i", err);
    }
    
}

// 获取崩溃统计的函数指针
- (NSUncaughtExceptionHandler *)getHandler {
    return NSGetUncaughtExceptionHandler();
}


@end
