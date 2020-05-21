//
//  TestWebViewController.h
//  HelloObjc
//
//  Created by jaben on 2020/5/20.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *mainWebView;

@end

NS_ASSUME_NONNULL_END
