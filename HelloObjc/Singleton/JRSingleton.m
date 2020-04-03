//
//  JRSingleton.m
//  HelloObjc
//
//  Created by jaben on 2020/2/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "JRSingleton.h"

@implementation JRSingleton

+ (instancetype)shareManager {
    static JRSingleton *_singleton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
//        _singleton = [[super allocWithZone:NULL] init];
        _singleton = [[JRSingleton alloc] init];
    });
    return _singleton;
}

+ (instancetype)alloc {
 //   NSLog(@"============ alloc ============");
    return [super alloc];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
 //   NSLog(@"============ alloc with zone ============");
    return [super allocWithZone:zone];
}

- (id)copyWithZone:(NSZone *)zone {
    return [JRSingleton shareManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [JRSingleton shareManager];
}

//- (instancetype)init {
//    NSLog(@"init");
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}

- (void)printName {
    NSLog(@"name=> %@", _name);
}

@end
