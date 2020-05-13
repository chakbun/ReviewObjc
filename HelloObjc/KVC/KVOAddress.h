//
//  KVOAddress.h
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOAddress : NSObject

@property (nonatomic, strong) NSString *line;
@property (nonatomic, assign) NSInteger postcode;

+ (instancetype)instanceWithLine:(NSString *)line code:(NSInteger)code;
@end

NS_ASSUME_NONNULL_END
