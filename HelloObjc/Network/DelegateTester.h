//
//  DelegateTester.h
//  HelloObjc
//
//  Created by jaben on 2020/5/10.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DelegateTester <NSObject>

@property (nonatomic, strong) NSString *delegateName;

- (NSInteger)count4Names;

@end


NS_ASSUME_NONNULL_END
