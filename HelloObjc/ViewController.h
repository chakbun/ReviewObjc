//
//  ViewController.h
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRPlayerView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *testButton;

@property (assign, nonatomic) int testInt;

@property (strong, nonatomic) NSString *testStr;

@property (weak, nonatomic) IBOutlet JRPlayerView *playerView;

@end

