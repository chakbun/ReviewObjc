//
//  JRSingleton.h
//  HelloObjc
//
//  Created by jaben on 2020/2/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRSingleton : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSString *title;

+ (instancetype)shareManager;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE; // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE; // 没有遵循协议可以不写

- (void)printName;
@end

NS_ASSUME_NONNULL_END
