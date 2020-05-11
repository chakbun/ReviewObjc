//
//  RunLoopTester.m
//  HelloObjc
//
//  Created by jaben on 2020/5/11.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "RunLoopTester.h"

@implementation RunLoopTester

- (void)addObserverOnMainThread {
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"============ kCFRunLoopEntry in Main Thread ============");
            break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"============ kCFRunLoopBeforeTimers in Main Thread ============");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"============ kCFRunLoopBeforeSources in Main Thread ============");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"============ kCFRunLoopBeforeWaiting in Main Thread ============");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"============ kCFRunLoopAfterWaiting in Main Thread ============");
                break;
            case kCFRunLoopExit:
                NSLog(@"============ kCFRunLoopExit in Main Thread ============");
                break;
            case kCFRunLoopAllActivities:
                NSLog(@"============ kCFRunLoopAllActivities in Main Thread ============");
                break;
            default:
        break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observerRef, kCFRunLoopDefaultMode);
    
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"============ time is up in Main Thread ============");
    }];
}

- (void)addObserverOnNewThread {
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"============ thread:%@ ============", [NSThread currentThread]);
        [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            NSLog(@"============ time is up in New Thread ============");
        }];
        
        CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            
            switch (activity) {
                case kCFRunLoopEntry:
                NSLog(@"============ kCFRunLoopEntry in New Thread ============");
                break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"============ kCFRunLoopBeforeTimers in New Thread ============");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"============ kCFRunLoopBeforeSources in New Thread ============");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"============ kCFRunLoopBeforeWaiting in New Thread ============");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"============ kCFRunLoopAfterWaiting in New Thread ============");
                    break;
                case kCFRunLoopExit:
                    NSLog(@"============ kCFRunLoopExit in New Thread ============");
                    break;
                case kCFRunLoopAllActivities:
                    NSLog(@"============ kCFRunLoopAllActivities in New Thread ============");
                    break;
                default:
            break;
            }
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopDefaultMode);
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
    }];
}

@end
