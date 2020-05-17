//
//  JRPlayerView.h
//  HelloObjc
//
//  Created by jaben on 2020/5/17.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRPlayerView : UIView

@property (nonatomic, strong) AVPlayer *player;

@end

NS_ASSUME_NONNULL_END
