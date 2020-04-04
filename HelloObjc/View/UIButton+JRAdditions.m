//
//  UIButton+JRAdditions.m
//  HelloObjc
//
//  Created by jaben on 2020/4/4.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "UIButton+JRAdditions.h"

@implementation UIButton (JRAdditions)

- (void)addBorderRadius:(int)radius {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10.0];
    
    CAShapeLayer *borderRadiusLayer = [CAShapeLayer layer];
    borderRadiusLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderRadiusLayer.path = bezierPath.CGPath;
    borderRadiusLayer.lineWidth = 1.0;
    borderRadiusLayer.strokeColor = self.backgroundColor.CGColor;
    borderRadiusLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.layer.mask = borderRadiusLayer;
    [self.layer addSublayer:borderRadiusLayer];
    
    self.backgroundColor = [UIColor clearColor];

}

@end
