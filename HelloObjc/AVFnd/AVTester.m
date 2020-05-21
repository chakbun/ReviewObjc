//
//  AVTester.m
//  HelloObjc
//
//  Created by jaben on 2020/5/16.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "AVTester.h"

static const NSString *ItemStatusContext;
static const NSString *PlayerStatusContext;

@interface AVTester ()

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) AVPlayerViewController *playerVC;
@end

@implementation AVTester

- (void)dealloc {
    [self.mPlayer removeObserver:self forKeyPath:@"status" context:NULL];
    [self.mPlayer removeTimeObserver:self];
}

- (void)loadAVPlayItemWithCompleted:(void(^)(int seconds))completed {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"happylover" ofType:@"mp4"];
    AVURLAsset *avsert = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    NSString *tracksKey = @"tracks";

     __weak __typeof(self) weakSelf = self;
    
    [avsert loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:^{
        
        NSError *error;
        AVKeyValueStatus status = [avsert statusOfValueForKey:@"tracks" error:&error];
        if (status == AVKeyValueStatusLoaded) {
            weakSelf.playerItem = [AVPlayerItem playerItemWithAsset:avsert];
             // ensure that this is done before the playerItem is associated with the player
            
            [weakSelf.playerItem addObserver:weakSelf forKeyPath:@"status"
                        options:NSKeyValueObservingOptionNew context:&ItemStatusContext];
            
            weakSelf.mPlayer = [[AVPlayer alloc] initWithPlayerItem:weakSelf.playerItem];
            [weakSelf.mPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:&PlayerStatusContext];
            [weakSelf.mPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                long long seconds = time.value/1000000000;
                weakSelf.currentTimeBlock((int)seconds);
            }];
            
            CMTime t = [[[[[weakSelf.playerItem tracks] objectAtIndex:0] assetTrack] asset] duration];
            long long seconds = t.value / t.timescale;
            completed((int)seconds);
        }
        else {
            // You should deal with the error appropriately.
            NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
        }
    }];
}

//- (AVPlayer *)mPlayer {
//    if (!_mPlayer) {
//
//
////        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
////        _mPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
////        _mPlayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
//
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPlay2EndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:NULL];
//
////        [_mPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:&PlayerStatusContext];
//
////        [self addObserver2Player:_mPlayer inTimes:@[@3, @9, @12]];
//        [self addObserver2Player:_mPlayer perSeconds:3];
//
//    }
//    return _mPlayer;
//}

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
    if (!self.playerVC) {
        self.playerVC = [AVPlayerViewController new];
    }
    
    __weak __typeof(self) weakSelf = self;
    [self loadAVPlayItemWithCompleted:^(int seconds){
        weakSelf.playerVC.player = weakSelf.mPlayer;
    }];
    return self.playerVC;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == &ItemStatusContext) {
        int status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay: {
                NSLog(@"============ AVPlayerItemSt atusReadyToPlay ============");
                break;
            }
            case AVPlayerItemStatusFailed:
                NSLog(@"============ AVPlayerItemStatusFailed ============");
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"============ AVPlayerItemStatusUnknown ============");
                break;
            default:
                break;
        }
        return;
    }else if(context == &PlayerStatusContext){
        if ([keyPath isEqualToString:@"currentTime"]) {
            NSLog(@"============ currentTime:%@ ============",change);
            if (self.currentTimeBlock) {
                self.currentTimeBlock(1);
            }
        }else {
            int status = [change[NSKeyValueChangeNewKey] intValue];
            switch (status) {
                case AVPlayerStatusReadyToPlay:
                    [self.mPlayer play];
                    NSLog(@"============ AVPlayerStatusReadyToPlay ============");
                    break;
                case AVPlayerStatusFailed:
                    NSLog(@"============ AVPlayerStatusFailed ============");
                    break;
                case AVPlayerStatusUnknown:
                    NSLog(@"============ AVPlayerStatusUnknown ============");
                    break;
                default:
                    break;
            }
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)listInputDevices {
    
    AVCaptureDeviceDiscoverySession *s = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInMicrophone, AVCaptureDeviceTypeBuiltInDualCamera] mediaType:nil position:AVCaptureDevicePositionUnspecified];
     
    for (AVCaptureDevice *device in s.devices) {
     
        NSLog(@"Device name: %@", [device localizedName]);
     
        if ([device hasMediaType:AVMediaTypeVideo]) {
     
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
            }
            else {
                NSLog(@"Device position : front");
            }
        }
    }
}
@end
