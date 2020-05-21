//
//  KeyCommandProtocol.h
//  HelloObjc
//
//  Created by jaben on 2020/5/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KeyCommandProtocol <NSObject>

@property (nonatomic, strong) NSString *keyName;

- (NSDictionary *)commonList;

- (float)avgInArray:(NSArray<NSNumber *> *)arr;

@end

NS_ASSUME_NONNULL_END
