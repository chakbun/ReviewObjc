//
//  UIFreezeMonitor.h
//  HelloObjc
//
//  Created by edz on 2021/9/6.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFreezeMonitor : NSObject

+ (instancetype)shareMonitor;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
