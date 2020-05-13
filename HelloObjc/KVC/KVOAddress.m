//
//  KVOAddress.m
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "KVOAddress.h"

@implementation KVOAddress

+ (instancetype)instanceWithLine:(NSString *)line code:(NSInteger)code {
    KVOAddress *add = [KVOAddress new];
    add.line = line;
    add.postcode = code;
    return add;
}

@end
