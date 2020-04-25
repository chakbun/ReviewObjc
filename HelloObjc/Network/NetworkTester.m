//
//  JRNetworkManager.m
//  HelloObjc
//
//  Created by jaben on 2020/4/12.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "NetworkTester.h"
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

void ServerConnectCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
     // ----判断是不是NULL
     if (data != NULL) {
         SInt32 errCode = *((int *)data);
         printf("连接失败, 错误码=%i \n", errCode);
     }else {
         NetworkTester *tester = (__bridge NetworkTester *)(info);
         [tester performSelectorInBackground:@selector(readStreamData4ClientInTCP) withObject:nil];
     }
}

void readStream(CFReadStreamRef iStream, CFStreamEventType eventType, void * clientCallBackInfo) {
    
    char buff[2048];
    bzero(buff, sizeof(buff));
    
    NSString *str = (__bridge NSString *)(clientCallBackInfo);
    NSLog(@"============ str = %@ ============", str);
    
    do {
        CFIndex dex = CFReadStreamRead(iStream, (UInt8 *)buff, sizeof(buff));
        if (dex > 0) {
            //
            printf("接收到数据: %s \n", buff);
        }
    }while (strcmp(buff, "exit") != 0);
}

void TCPServerAcceptCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    
    if (kCFSocketAcceptCallBack == type) {
        CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
        
        uint8_t name[SOCK_MAXADDRLEN];
        socklen_t nameLen = sizeof(name);

        if (getpeername(nativeSocketHandle, (struct sockaddr *)name, &nameLen) != 0) {
            exit(1);
        }
        
        struct sockaddr_in *addr_in = (struct sockaddr_in *)name;
        char *ip_addr = inet_ntoa(addr_in->sin_addr);
        int ip_port = addr_in->sin_port;
        
        NSLog(@"============ socket accept: ip=%s, port=%i ============", ip_addr, ip_port);
        
        CFReadStreamRef inputStream = NULL;
        CFWriteStreamRef outputStream = NULL;
        
        CFStreamCreatePairWithSocket(kCFAllocatorDefault, nativeSocketHandle, &inputStream, &outputStream);
        
        if (inputStream && outputStream) {
            CFReadStreamOpen(inputStream);
            CFWriteStreamOpen(outputStream);
            
            CFStreamClientContext streamContext = {0, NULL, NULL, NULL};
            
            if (!CFReadStreamSetClient(inputStream, kCFStreamEventHasBytesAvailable, readStream, &streamContext)) {
                exit(1);
            }
            
            CFReadStreamScheduleWithRunLoop(inputStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
            
            char *helloStr = "Hello Client";
            CFWriteStreamWrite(outputStream, (UInt8 *)helloStr, strlen(helloStr));
        }
        
    }
}

@interface NetworkTester ()

@property (nonatomic, assign) CFSocketRef clientSocketRef;

@property (nonatomic, assign) CFSocketRef serverSocketRef;

@end

@implementation NetworkTester

- (void)quickStartHTTPTask {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.dataatwork.org/v1/spec/skills-api.json"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       NSLog(@"============ data ============");
    }];
    
    [task resume];
}

#pragma mark - Client 4 TCP
- (void)initClientTCPSocketAndConnectServerIP:(NSString *)ip port:(int)port {

    CFSocketContext ctx = {0, (__bridge void *)self, 0, 0, 0};
    self.clientSocketRef = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketConnectCallBack, ServerConnectCallBack, &ctx);
    
    CFDataRef dataRef = [NetworkTester CFDataCreateWithIP:ip port:port];
    
    CFSocketError result = CFSocketConnectToAddress(self.clientSocketRef, dataRef, -1);
    
    CFRelease(dataRef);
    
    CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
    CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self.clientSocketRef, 0);
    CFRunLoopAddSource(runLoopRef, sourceRef, kCFRunLoopCommonModes);
    CFRelease(sourceRef);
    CFRunLoopRun();
}

- (void)readStreamData4ClientInTCP {
    
    char buffer[512];
    
    /**
        int recv( SOCKET s, char FAR *buf, int len, int flags );

     不论是客户还是服务器应用程序都用recv函数从TCP连接的另一端接收数据。

     （1）第一个参数指定接收端套接字描述符；

     （2）第二个参数指明一个缓冲区，该缓冲区用来存放recv函数接收到的数据；

     （3）第三个参数指明buf的长度；

     （4）第四个参数一般置0。

     */
    long readData;
    //若无错误发生，recv()返回读入的字节数。如果连接已中止，返回0。如果发生错误，返回-1，应用程序可通过perror()获取相应错误信息
    while((readData = recv(CFSocketGetNative(self.clientSocketRef), &buffer, sizeof(buffer), 0))) {
        NSString *content = [[NSString alloc] initWithBytes:buffer length:readData encoding:NSUTF8StringEncoding];
        NSLog(@"content = %@", content);
        if ([content containsString:@"Hello"]) {
            [self sendStreamData4ClientInTCP];
        }
    };
    
    perror("recv");
}

- (void)sendStreamData4ClientInTCP {
    
    NSString *str = @"hello world";
    // 发送数据
    ssize_t sendLen = send(CFSocketGetNative(self.clientSocketRef), str.UTF8String, strlen(str.UTF8String), 0);
    if (sendLen > 0) {
        //success
        NSString *str = @"exit";
        send(CFSocketGetNative(self.clientSocketRef), str.UTF8String, strlen(str.UTF8String), 0);
    }
    
}

#pragma mark - Server 4 TCP
- (void)initSocket4ServerInTCP {
    
    CFSocketContext ctx = {0, (__bridge void *)self, 0, 0, 0};

    self.serverSocketRef = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack, TCPServerAcceptCallBack, &ctx);
    
    if (!self.serverSocketRef) {
        NSLog(@"============ create server socket fail ============");
        return;
    }
    
    BOOL reused = YES;
    setsockopt(CFSocketGetNative(self.serverSocketRef), SOL_SOCKET, SO_REUSEADDR, (const void *)&reused, sizeof(reused));
    
    CFDataRef dataRef = [NetworkTester CFDataCreateWithIP:@"127.0.0.1" port:4327];
    CFSocketError err = CFSocketSetAddress(self.serverSocketRef, dataRef);
    CFRelease(dataRef);

    if(err != kCFSocketSuccess) {
        if (self.serverSocketRef) {
            CFRelease(self.serverSocketRef);
            exit(1);
        }
        self.serverSocketRef = NULL;
    }
    
    CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
    CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self.serverSocketRef, 0);
    CFRunLoopAddSource(runLoopRef, sourceRef, kCFRunLoopCommonModes);
    CFRelease(sourceRef);
    CFRunLoopRun();
    
}

#pragma mark - Common
+ (CFDataRef)CFDataCreateWithIP:(NSString *)ip port:(int)port {
    
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    
    addr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    addr.sin_port = htons(port);
    addr.sin_family = AF_INET;
    addr.sin_len = sizeof(addr);
    
    CFDataRef dataRef = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr, sizeof(addr));
    return dataRef;

}


@end
