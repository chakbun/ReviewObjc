//
//  ProtocolManager.m
//  HelloObjc
//
//  Created by jaben on 2020/5/21.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "ProtocolManager.h"

@interface ProtocolManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject *> *protocolDictionary;
@property (nonatomic, strong) NSLock *protocolLock;

@end

@implementation ProtocolManager
+ (instancetype)shareManager {
    static ProtocolManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[ProtocolManager alloc] init];
    });
    return shareManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _protocolDictionary = [NSMutableDictionary dictionary];
        _protocolLock = [NSLock new];
    }
    return self;
}

- (void)addProtocol:(id)protocol withProtocolName:(NSString *)name {
    [self.protocolLock lock];
    self.protocolDictionary[name] = protocol;
    [self.protocolLock unlock];
}

- (void)removeProtocolWithName:(NSString *)name {
    [self.protocolLock lock];
    [self.protocolDictionary removeObjectForKey:name];
    [self.protocolLock unlock];
}

- (id)protocolWithName:(NSString *)name {
    [self.protocolLock lock];
    id protocol = self.protocolDictionary[name];
    [self.protocolLock unlock];
    return protocol;
}

@end
