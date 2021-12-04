//
//  UIFreezeMonitor.m
//  HelloObjc
//
//  Created by edz on 2021/9/6.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "UIFreezeMonitor.h"

static NSInteger freezeTimeOut = 50; //ms

@interface UIFreezeMonitor () {
    CFRunLoopObserverRef _allActivityObser;
}

@property (atomic, assign) NSInteger state; //0:stop 1:working
@property (nonatomic, strong) dispatch_semaphore_t stateChangedSemaphore;
@property (nonatomic, assign) CFRunLoopActivity runloopState;

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

- (instancetype)init {
    if (self = [super init]) {
        _stateChangedSemaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)start {
    
    if (_allActivityObser || self.state == 1) {
        return;
    }
    
    self.state = 1;
    
    CFRunLoopObserverContext context = {0, (__bridge void*)self, NULL, NULL};
    _allActivityObser = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _allActivityObser, kCFRunLoopCommonModes);
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (weakSelf.state == 1) {
            intptr_t timeoutFlag =  dispatch_semaphore_wait(weakSelf.stateChangedSemaphore, dispatch_time(DISPATCH_TIME_NOW, 50 * NSEC_PER_MSEC));
            if (timeoutFlag != 0) {
                // time out;
                //判断状态
                if (weakSelf.runloopState == kCFRunLoopBeforeSources || weakSelf.runloopState == kCFRunLoopAfterWaiting) {
//                    NSLog(@"~~~~~~>work NOT smoothly~~~~~~~~>");
                }
            }
        }
    });
}

- (void)stop {
    self.state = 0;
    CFRunLoopObserverInvalidate(_allActivityObser);
    CFRelease(_allActivityObser);
    _allActivityObser = nil;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    UIFreezeMonitor *freezeMonitor = (__bridge UIFreezeMonitor *)(info);
    freezeMonitor.runloopState = activity;
    dispatch_semaphore_signal(freezeMonitor.stateChangedSemaphore);
    
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"[Run Loop] kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"[Run Loop] kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"[Run Loop] kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"[Run Loop] kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"[Run Loop] kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"[Run Loop] kCFRunLoopExit");
            break;
        case kCFRunLoopAllActivities:
            NSLog(@"[Run Loop] kCFRunLoopAllActivities");
            break;
        default:
            NSLog(@"[Run Loop] Unknow activity: %li", activity);
            break;
    }
}

@end
