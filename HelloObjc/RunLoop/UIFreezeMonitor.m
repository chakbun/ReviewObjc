//
//  UIFreezeMonitor.m
//  HelloObjc
//
//  Created by edz on 2021/9/6.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "UIFreezeMonitor.h"

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//    switch (activity) {
//        case kCFRunLoopEntry:
//            NSLog(@"[Run Loop] kCFRunLoopEntry");
//            break;
//        case kCFRunLoopBeforeTimers:
//            NSLog(@"[Run Loop] kCFRunLoopBeforeTimers");
//            break;
//        case kCFRunLoopBeforeSources:
//            NSLog(@"[Run Loop] kCFRunLoopBeforeSources");
//            break;
//        case kCFRunLoopBeforeWaiting:
//            NSLog(@"[Run Loop] kCFRunLoopBeforeWaiting");
//            break;
//        case kCFRunLoopAfterWaiting:
//            NSLog(@"[Run Loop] kCFRunLoopAfterWaiting");
//            break;
//        case kCFRunLoopExit:
//            NSLog(@"[Run Loop] kCFRunLoopExit");
//            break;
//        case kCFRunLoopAllActivities:
//            NSLog(@"[Run Loop] kCFRunLoopAllActivities");
//            break;
//        default:
//            NSLog(@"[Run Loop] Unknow activity: %li", activity);
//            break;
//    }
}

@interface UIFreezeMonitor () {
    CFRunLoopObserverRef _allActivityObser;
    NSTimer *_checkTimer;
}

@end

@implementation UIFreezeMonitor

+ (instancetype)shareMonitor {
    static UIFreezeMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[UIFreezeMonitor allocWithZone:NULL] init];
    });
    return monitor;
}

- (void)start {
    
    if(_checkTimer && _checkTimer.isValid) {
//        _checkTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(<#selector#>) userInfo:<#(nullable id)#> repeats:<#(BOOL)#>]
    }
    
    if (_allActivityObser) {
        return;
    }
    _allActivityObser = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, &runLoopObserverCallBack, NULL);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _allActivityObser, kCFRunLoopCommonModes);
}

@end
