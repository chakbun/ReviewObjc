//
//  ProtocolManager.h
//  HelloObjc
//
//  Created by jaben on 2020/5/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocolManager : NSObject


+ (instancetype)shareManager;

- (void)addProtocol:(id)protocol withProtocolName:(NSString *)name;
- (void)removeProtocolWithName:(NSString *)name;

- (id)protocolWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
