//
//  SecViewController.m
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (SecViewController *(^)(UIColor *color))setUpBackGroundColor {
    return ^(UIColor *color) {
        self.view.backgroundColor = color;
        return self;
    };
}

@end
