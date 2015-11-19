//
//  TemplateUtil.h
//  icar
//
//  Created by Killer on 15/11/13.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#ifndef __TBorder__struct
#define __TBorder__struct
typedef struct {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} TBorder;
#endif

@interface PrivateButtonBackground : UIButton
@property (nonatomic, strong) UIColor *downBackgroundColor;
@property (nonatomic, strong) UIColor *upBackGroundColor;
@end

TBorder TBorderMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left);

@interface TemplateUtil : NSObject


+(UIButton *) buttonWithImage: (UIImage *) image frame: (CGRect) frame;

+(UIButton *) button: (NSString *) title fontSize: (CGFloat)size color: (UIColor *) color frame: (CGRect) frame radius: (CGFloat)radius border: (CGFloat) width borderColor: (UIColor *) borderColor bgColor: (UIColor *) bgColor;

+(UILabel *) label: (NSString *) title fontSize: (CGFloat)size color: (UIColor *) color frame:(CGRect)frame;

+(UIView *) view: (CGRect) frame bgColor: (UIColor *) bgColor borderColor: (UIColor *) borerColor border: (TBorder) border;

+(void)buttonTouchDownChangeBackground: (id) button;
+(void)buttonTouchUpChangeBackground: (id) button;

@end
