//
//  RunLoopTester.h
//  HelloObjc
//
//  Created by jaben on 2020/5/11.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunLoopTester : NSObject

- (void)addObserverOnMainThread;

- (void)addObserverOnNewThread;

@end

NS_ASSUME_NONNULL_END
