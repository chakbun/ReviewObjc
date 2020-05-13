//
//  KVOPerson.h
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KVOCard.h"
#import "KVOAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVOPerson : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSMutableArray<KVOCard *> *cards;
@property (nonatomic, strong) KVOAddress *address;

+ (instancetype)quickPersonWithName:(NSString *)name age:(int)age;

@end

NS_ASSUME_NONNULL_END
