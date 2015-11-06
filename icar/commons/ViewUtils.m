//
//  ViewUtils.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ViewUtils.h"

@implementation ViewUtils


+(UIButton *)buttonWithTitle:(NSString *)title withFrame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle: title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = frame;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    btn.backgroundColor = [UIColor whiteColor];

    return btn;
}

@end

