//
//  ViewUtils.h
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface ViewUtils : NSObject

/**
 *  快速创建一个按钮
 */
+(UIButton *) buttonWithTitle:(NSString *) title withFrame: (CGRect) frame;

/**
 *  为视图添加圆角效果
 *
 *  @param target 目标视图
 *  @param width  圆角的宽度，如果需要正圆效果，width等于视图的高度/2
 */
+(void)view: (UIView *) target radius: (CGFloat) width;


/**
 *  为视图添加阴影效果
 *
 *  @param target 目标视图
 *  @param color 颜色
 *  @param size 偏移
 *  @param opacity 阴影的透明度，0.0表示透明，1.0表示不透明
 *  @param radius 设置阴影的宽度
 */
+(void)view: (UIView *) target shadowColor: (UIColor *) color offset: (CGSize) size opacity: (float) opacity radius: (float) radius;

/* 创建一条分割线的视图，该接口其实没什么实际意义，可能方便以后统一扩展吧，暂且保留该接口方法  */
+(UIView *)createSplitLineView: (CGRect)frame color: (UIColor *) color;

/* 根据文本内容字体大小计算文本的高度和宽度  */
+(CGSize) sizeWithLines: (NSString *) labelText fontSize: (CGFloat) fontSize width: (CGFloat) width;
+(CGSize) sizeWithSingleLine: (NSString *) labelText fontSize: (CGFloat) fontSize;

/* 自动消失的提示框 */
+(void)showMessage:(NSString *)message;

@end
