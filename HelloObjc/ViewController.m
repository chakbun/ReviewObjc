//
//  ViewController.m
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
#import "JRSingleton.h"
#import "MultipleThreadController.h"
#import "RuntimeTester.h"
#import "CopyTester.h"
#import "UIImageView+JRAdditions.h"
#import "UIButton+JRAdditions.h"
#import "JRPerferenceManager.h"
#import "CoreDataTester.h"
#import "Employee.h"
#import "NetworkTester.h"
#import "RunLoopTester.h"
#import "KVOCTester.h"
#import "AVTester.h"

@interface ViewController ()

@property (nonatomic, strong) AVTester *tester;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tester = [AVTester new];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)testButtonAction:(id)sender {
    
     __weak __typeof(self) weakSelf = self;
    [self.tester loadAVPlayItemWithCompleted:^{
        weakSelf.tester.mPlayer.rate = 1.0;
        weakSelf.playerView.player = weakSelf.tester.mPlayer;
    }];

}

@end
