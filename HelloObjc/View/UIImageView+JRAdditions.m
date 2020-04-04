//
//  UIImageView+JRAdditions.m
//  HelloObjc
//
//  Created by jaben on 2020/4/3.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "UIImageView+JRAdditions.h"

@implementation UIImageView (JRAdditions)

- (void)addBorderRadius:(int)radius {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] addClip];
    [self drawRect:self.frame];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
