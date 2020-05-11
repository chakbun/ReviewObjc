//
//  JRNetworkManager.h
//  HelloObjc
//
//  Created by jaben on 2020/4/12.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelegateTester.h"

NS_ASSUME_NONNULL_BEGIN


@interface NetworkTester : NSObject

@property (nonatomic, weak) id<DelegateTester> delegate;

- (void)testDelegate;
- (void)quickStartHTTPTask;

//TCP
- (void)initClientTCPSocketAndConnectServerIP:(NSString *)ip port:(int)port;
- (void)readStreamData4ClientInTCP;
- (void)sendStreamData4ClientInTCP;

//UDP
- (void)initClientUDPSenderIP:(NSString *)ip port:(int)port;
- (void)sendDataInUDP;

//Server
- (void)initSocket4ServerInTCP;


@end

NS_ASSUME_NONNULL_END
