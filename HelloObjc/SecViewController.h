//
//  SecViewController.h
//  HelloObjc
//
//  Created by jaben on 2020/2/8.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecViewController : UIViewController

@property (nonatomic, copy) SecViewController *(^setUpBackGroundColor)(UIColor *color);
@property (nonatomic, copy) SecViewController *(^setUpTitle)(NSString *title);

@end

NS_ASSUME_NONNULL_END
