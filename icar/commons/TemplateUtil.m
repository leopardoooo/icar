//
//  TemplateUtil.m
//  icar
//
//  Created by Killer on 15/11/13.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "TemplateUtil.h"
#import "UIView+Border.h"
#import "MacroDefine.h"

TBorder TBorderMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left){
    TBorder border = {top, right, bottom, left};
    return border;
}

@implementation PrivateButtonBackground
@end

/**
 *  视图模板工具类，提供了大量常用组件的生成方法，避免冗长无逻辑的代码出现
 */
@implementation TemplateUtil

/**
 *  快速创建一个图片按钮
 */
+(UIButton *) buttonWithImage: (UIImage *) image frame: (CGRect) frame {
    UIButton *target = [UIButton buttonWithType:UIButtonTypeCustom];
    target.frame = frame;
    [target setImage:image forState:UIControlStateNormal];
    return target;
}

/**
 *  快速创建一个文本按钮，通过一些常用的配置
 */
+(UIButton *) button: (NSString *) title fontSize: (CGFloat)size color: (UIColor *) color frame: (CGRect) frame radius: (CGFloat)radius border: (CGFloat) width borderColor: (UIColor *) borderColor bgColor: (UIColor *) bgColor{
    PrivateButtonBackground *target = [PrivateButtonBackground buttonWithType:UIButtonTypeCustom];
    target.titleLabel.font = [UIFont systemFontOfSize:size];
    [target setTitle:title forState:UIControlStateNormal];
    [target setTitleColor:color forState:UIControlStateNormal];
    target.frame = frame;
    
    // 圆角
    if(radius > 0.0){
        target.layer.cornerRadius = radius;
    }
    
    // 边框
    if(width > 0.0){
        target.layer.borderColor = borderColor.CGColor;
        target.layer.borderWidth = width;
    }
    
    // 背景颜色
    if(!bgColor){
        bgColor = [UIColor whiteColor];
    }
    target.backgroundColor = bgColor;
    // 点击的背景颜色
    target.upBackGroundColor = bgColor;
    target.downBackgroundColor = [UIColor colorWithWhite:0.000 alpha:0.250];
    
    [target addTarget:self action:@selector(buttonTouchDownChangeBackground:) forControlEvents:UIControlEventTouchDown];
    [target addTarget:self action:@selector(buttonTouchUpChangeBackground:) forControlEvents:UIControlEventTouchUpInside];
    [target addTarget:self action:@selector(buttonTouchUpChangeBackground:) forControlEvents:UIControlEventTouchUpOutside];
    
    return target;
    
}

+(void)buttonTouchDownChangeBackground: (id) sender{
    PrivateButtonBackground *target = sender;
    target.backgroundColor = target.downBackgroundColor;
//    target.backgroundColor = [target.backgroundColor colorWithAlphaComponent:.5];
}
+(void)buttonTouchUpChangeBackground: (id) sender{
    PrivateButtonBackground *target = sender;
    target.backgroundColor = target.upBackGroundColor;
//    target.backgroundColor = [target.backgroundColor colorWithAlphaComponent:1];
}

/**
 *  快速创建一个文本label
 */
+(UILabel *) label: (NSString *) title fontSize: (CGFloat)size color: (UIColor *) color frame:(CGRect)frame{
    UILabel *target = [[UILabel alloc] initWithFrame:frame];
    target.text = title;
    target.textColor = color;
    target.font = [UIFont systemFontOfSize:size];
    
    return target;
}

+(UIView *) view: (CGRect) frame bgColor: (UIColor *) bgColor borderColor: (UIColor *) borerColor border: (TBorder) border{
    UIView *target = [[UIView alloc] initWithFrame:frame];
    target.backgroundColor = [UIColor whiteColor];
    
    if(border.top > 0){
        [target addBottomBorderWithColor:borerColor andWidth:border.top];
    }
    
    if(border.right > 0){
        [target addBottomBorderWithColor:borerColor andWidth:border.right];
    }
    
    if(border.bottom > 0){
        [target addBottomBorderWithColor:borerColor andWidth:border.bottom];
    }
    
    if(border.left > 0){
        [target addBottomBorderWithColor:borerColor andWidth:border.left];
    }
    
    return target;
}
@end
