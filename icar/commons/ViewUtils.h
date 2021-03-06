//
//  ViewUtils.h
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

// 枚举消息图标类型
typedef enum {
    // 普通提示消息
    JLMessageIconTypeInfo,
    // 警告消息
    JLMessageIconTypeWarn,
    // 操作完成
    JLMessageIconTypeCompleted,
    // 错误消息
    JLMessageIconTypeError,
    // loading
    JLMessageIconTypeLoading
    
} JLMessageIconType ;

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

/* 为视图指定的角添加圆角效果
 any: UIRectCornerBottomLeft | UIRectCornerBottomRight 下左及下右
 any: UIRectCornerTopLeft | UIRectCornerTopRight 上左及上右
 */
+(void) viewAnyRadius: (UIView *) target any: (UIRectCorner) any radius: (CGSize) size;

/* 在keyWindow自动消失的提示框, 图标类型可以通过枚举类型指定 */
+(void)showAnyIconMessage: (JLMessageIconType) iconType withMessage:(NSString *) message;

+(void)showTextMessage: (NSString *) message;


@end
