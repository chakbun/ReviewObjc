//
//  TestWebViewController.m
//  HelloObjc
//
//  Created by jaben on 2020/5/20.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "TestWebViewController.h"

@interface TestWebViewController ()

@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"web" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.mainWebView loadRequest:request];
    [self.mainWebView evaluateJavaScript:@"helloJS('warning!')" completionHandler:^(id handler, NSError * _Nullable error) {
        NSLog(@"============ ok ============");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
