//
//  JRNetworkManager.m
//  HelloObjc
//
//  Created by jaben on 2020/4/12.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "JRNetworkManager.h"

@implementation JRNetworkManager

- (void)startATask {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.dataatwork.org/v1/spec/skills-api.json"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       NSLog(@"============ data ============");
    }];
    
    [task resume];
}
@end
