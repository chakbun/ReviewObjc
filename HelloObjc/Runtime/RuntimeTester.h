//
//  RuntimeTester.h
//  HelloObjc
//
//  Created by jaben on 2020/3/29.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTester : NSObject

- (void)test;
- (void)addMethod;

- (void)replaceMethod;

- (NSString *)statementWithReturnAndParametersA:(int)a andString:(NSString *)b;

- (void)statementWithOutReturn;

- (void)getProperties;

- (void)sendMessage2Self;

- (void)sendMessage2Nil;

@end

NS_ASSUME_NONNULL_END
