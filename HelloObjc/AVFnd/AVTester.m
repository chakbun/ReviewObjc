//
//  AVTester.m
//  HelloObjc
//
//  Created by jaben on 2020/5/16.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "AVTester.h"
#import <AVKit/AVKit.h>

static const NSString *ItemStatusContext;

@interface AVTester ()

@property (nonatomic, strong) AVPlayer *mPlayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@end

@implementation AVTester

- (void)dealloc {
    [self.mPlayer removeObserver:self forKeyPath:@"status" context:NULL];
    [self.mPlayer removeTimeObserver:self];
}

- (void)loadAVPlayItem {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"happylover" ofType:@"mp4"];
    AVURLAsset *avsert = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    NSString *tracksKey = @"tracks";

     __weak __typeof(self) weakSelf = self;
    
    [avsert loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:^{
        
        NSError *error;
        AVKeyValueStatus status = [avsert statusOfValueForKey:tracksKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            weakSelf.playerItem = [AVPlayerItem playerItemWithAsset:avsert];
             // ensure that this is done before the playerItem is associated with the player
            [weakSelf.playerItem addObserver:weakSelf forKeyPath:@"status"
                        options:NSKeyValueObservingOptionInitial context:&ItemStatusContext];
        }
        else {
            // You should deal with the error appropriately.
            NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
        }
    }];
}

- (AVPlayer *)mPlayer {
    if (!_mPlayer) {
        
        
//        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
//        _mPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
//        _mPlayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPlay2EndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:NULL];
        
//        [_mPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
        
//        [self addObserver2Player:_mPlayer inTimes:@[@3, @9, @12]];
//        [self addObserver2Player:_mPlayer perSeconds:3];
        
    }
    return _mPlayer;
}

- (void)didPlay2EndTime:(NSNotification *)notify {
    NSLog(@"============ end!!! ============");
}

- (void)addObserver2Player:(AVPlayer *)player inTimes:(NSArray *)times {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSNumber *time in times) {
        [arr addObject:[NSValue valueWithCMTime:CMTimeMake([time intValue], 1)]];
    }
    
    [player addBoundaryTimeObserverForTimes:arr queue:dispatch_get_main_queue() usingBlock:^{
        NSLog(@" Boundary time time");
    }];
}

- (void)addObserver2Player:(AVPlayer *)player perSeconds:(int)seconds {
    // add period time observer
    CMTime time = CMTimeMake(seconds, 1);
    [player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@" target time time=>%.f  ", time.value/1000000000.0);
    }];
}

- (id)playerController {
    AVPlayerViewController *vc = [AVPlayerViewController new];
    
    
    vc.player = self.mPlayer;
    return vc;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == &ItemStatusContext) {
        return;
    }else {
        int status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:
                [self.mPlayer play];
                break;
            case AVPlayerStatusFailed:
                break;
            case AVPlayerStatusUnknown:
                break;
            default:
                break;
        }
        return;
    }
    

}

@end
