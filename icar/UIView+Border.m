//
//  UIView+Border.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:layer];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    
    layer.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:layer];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    
    layer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:layer];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    
    layer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:layer];
}


@end
