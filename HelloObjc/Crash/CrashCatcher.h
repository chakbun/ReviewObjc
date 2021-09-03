//
//  CrashCatcher.h
//  HelloObjc
//
//  Created by edz on 2021/9/2.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashCatcher : NSObject

+ (instancetype)shareInstance;

- (void)handleException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
