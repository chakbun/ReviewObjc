//
//  AVTester.h
//  HelloObjc
//
//  Created by jaben on 2020/5/16.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVTester : NSObject

@property (nonatomic, strong) AVPlayer *mPlayer;

- (id)playerController;
- (void)loadAVPlayItemWithCompleted:(void(^)(int seconds))completed;

@end

NS_ASSUME_NONNULL_END
