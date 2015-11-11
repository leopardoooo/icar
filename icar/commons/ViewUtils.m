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

+(void)view: (UIView *) target radius: (CGFloat) width{
    if(target){
        target.layer.masksToBounds = YES;
        target.layer.cornerRadius = width;
    }
}

+(void)view: (UIView *) target shadowColor: (UIColor *) color offset: (CGSize) size opacity: (float) opacity radius: (float) radius{
    if(target){
        [target.layer setShadowColor: color.CGColor];
        [target.layer setShadowOffset: size];
        [target.layer setShadowRadius:radius];
        [target.layer setShadowOpacity:opacity];
    }
}

+(UIView *)createSplitLineView: (CGRect)frame color: (UIColor *) color{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    line.backgroundColor = color;
    
    return line;
}

@end

