//
//  KeyCommandManager.h
//  HelloObjc
//
//  Created by jaben on 2020/5/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyCommandManager : NSObject

+ (instancetype)shareManager;

- (float)keyCalculationAction:(NSArray<NSNumber *> *)arr;

- (NSDictionary *)keyCommandList;

@end

NS_ASSUME_NONNULL_END
