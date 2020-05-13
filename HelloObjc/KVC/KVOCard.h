//
//  KVOCard.h
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOCard : NSObject

@property (nonatomic, strong) NSString *sn;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) float fee;

@property (nonatomic, strong) NSString *level;

+ (NSArray *)generateCards:(int)count;

@end

NS_ASSUME_NONNULL_END
