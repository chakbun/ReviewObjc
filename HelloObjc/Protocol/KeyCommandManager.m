//
//  KeyCommandManager.m
//  HelloObjc
//
//  Created by jaben on 2020/5/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "KeyCommandManager.h"
#import "KeyCommandProtocol.h"

@interface KeyCommandManager ()<KeyCommandProtocol>


@end

@implementation KeyCommandManager

@synthesize keyName;

+ (instancetype)shareManager {
    static KeyCommandManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KeyCommandManager alloc] init];
        
    });
    
    return manager;
}

- (float)keyCalculationAction:(NSArray<NSNumber *> *)arr {
    float total = [[arr valueForKeyPath:@"@avg"] floatValue];
    return total;
}

- (NSDictionary *)keyCommandList {
    return @{@"att": @"15", @"def":@"12"};
}

#pragma mark - KeyCommandProtocol

- (NSDictionary *)commonList {
    return [self keyCommandList];
}

- (float)avgInArray:(NSArray<NSNumber *> *)arr {
    return [self keyCalculationAction:arr];
}


@end
