//
//  JRPlayerView.m
//  HelloObjc
//
//  Created by jaben on 2020/5/17.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "JRPlayerView.h"

@interface JRPlayerView ()


@end

@implementation JRPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [((AVPlayerLayer *)[self layer]) player];
}

- (void)setPlayer:(AVPlayer *)player {
    dispatch_async(dispatch_get_main_queue(), ^{
        [((AVPlayerLayer *)[self layer]) setPlayer:player];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
