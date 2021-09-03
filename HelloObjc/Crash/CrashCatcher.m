//
//  CrashCatcher.m
//  HelloObjc
//
//  Created by edz on 2021/9/2.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "CrashCatcher.h"
#import <libkern/OSAtomic.h>
#import <stdatomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>

const NSInteger handleExceptionBacktraceFramesCount = 20;
NSString * const handleExceptionSignalExceptionName = @"handleExceptionSignalExceptionName";
NSString * const handleExceptionSignalKey = @"handleExceptionSignalKey";
NSString * const handleExceptionAddressesKey = @"handleExceptionAddressesKey";

static void exceptionCausedCrashHandler(NSException * exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    [[[CrashCatcher alloc] init] performSelector:@selector(handleException:) withObject:exception];
}

static void signalCausedCrashHandler(int signal) {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:handleExceptionSignalKey];
    
    void *callStack[128];
    int frames = backtrace(callStack, 128);
    char **strs = backtrace_symbols(callStack, frames);
    
    NSMutableArray *symbolsBackTrace=[NSMutableArray arrayWithCapacity:frames];
    
    unsigned long count = handleExceptionBacktraceFramesCount < frames ? handleExceptionBacktraceFramesCount : frames;
    for (int i = 0; i < count; i++) {
        [symbolsBackTrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    [userInfo setObject:symbolsBackTrace forKey:handleExceptionAddressesKey];
    
    NSException *signalException = [NSException exceptionWithName:handleExceptionSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raised.",signal] userInfo:userInfo];
    
    [[[CrashCatcher alloc] init] performSelector:@selector(handleException:) withObject:signalException];
}

//static void signalCausedCrashHandler(int crashSignal, struct __siginfo *info, void *context) {
//
//    static volatile int32_t UncaughtExceptionCount = 0;
//    static const int32_t UncaughtExceptionMaximum = 10;
//
//    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
//    if (exceptionCount <= UncaughtExceptionMaximum) {
//        NSDictionary *userInfo = @{@"UncaughtExceptionHandlerSignalKey": @(crashSignal)};
//        NSString *reason;
//        @try {
//            reason = [NSString stringWithFormat:@"Signal %d was raised.", crashSignal];
//        } @catch(NSException *exception) {
//            //ignored
//        }
//
//        @try {
//            NSException *exception = [NSException exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
//                                                             reason:reason
//                                                           userInfo:userInfo];
//            NSLog(@"---> ", exception);
//        } @catch(NSException *exception) {
//
//        }
//    }
//}

@interface CrashCatcher ()

@property (nonatomic, assign) BOOL dismissed;

@end


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
    NSSetUncaughtExceptionHandler(&exceptionCausedCrashHandler);
    
//    struct sigaction action;
//    sigemptyset(&action.sa_mask);
//    action.sa_flags = SA_SIGINFO;
//    action.sa_sigaction = &UncaughtSinal;
    int signals[] = {SIGABRT, SIGILL, SIGSEGV, SIGFPE, SIGBUS};
    for (int i = 0; i < sizeof(signals) / sizeof(int); i++) {
//        struct sigaction prev_action;
//        int err = sigaction(signals[i], &action, &prev_action);
        signal(signals[i], &signalCausedCrashHandler);
//        NSLog(@"sigaction err = %i", err);
    }
}

- (void)showCrashToastWithMessage:(NSString *)message {
    UILabel *crashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height - 64)];
    crashLabel.textColor = [UIColor redColor];
    crashLabel.font = [UIFont systemFontOfSize:15];
    crashLabel.text = message;
    crashLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    crashLabel.numberOfLines = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:crashLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(crashToastTapAction:)];
    crashLabel.userInteractionEnabled = YES;
    [crashLabel addGestureRecognizer:tap];
}

- (void)crashToastTapAction:(UITapGestureRecognizer *)tap {
    UILabel *crashLabel = (UILabel *)tap.view;
    [UIPasteboard generalPasteboard].string = crashLabel.text;
    self.dismissed = YES;
}

- (void)handleException:(NSException *)exception {
    NSString *stackInfo = [[exception userInfo] objectForKey:handleExceptionAddressesKey];
    
    
#ifdef DEBUG
    NSString *message = [NSString stringWithFormat:@"抱歉，APP发生了异常，请与开发人员联系，点击屏幕继续并自动复制错误信息到剪切板。\n\n异常报告:\n异常名称：%@\n异常原因：%@\n堆栈信息：%@\n", [exception name], [exception reason], stackInfo];
    NSLog(@"%@",message);
    [self showCrashToastWithMessage:message];

    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    while (!self.dismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            //为阻止线程退出，使用 CFRunLoopRunInMode(model, 0.001, false)等待系统消息，false表示RunLoop没有超时时间
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    CFRelease(allModes);


#endif
    
//    [RCCrashLog collectCrashInfoWithException:exception exceptionStackInfo:stackInfo viewControllerStackInfo:[self getCurrentViewControllerStackInfo]];
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGHUP, SIG_DFL);
    signal(SIGINT, SIG_DFL);
    signal(SIGQUIT, SIG_DFL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:handleExceptionSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:handleExceptionSignalKey] intValue]);
    } else {
        [exception raise];
    }
    
}

- (NSUncaughtExceptionHandler *)getHandler {
    return NSGetUncaughtExceptionHandler();
}

@end
