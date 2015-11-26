//
//  CountInputView.h
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountInputView : UIView

/* 减操作按钮 */
@property (nonatomic, strong, readonly) UIButton *minusBtn;
/* 加操作按钮 */
@property (nonatomic, strong, readonly) UIButton *plusBtn;
/* 文本框 */
@property (nonatomic, strong, readonly) UITextField *countField;

/* 计数器最大值 */
@property (nonatomic, assign) NSUInteger maxValue;
/* 计数器最小值 */
@property (nonatomic, assign) NSUInteger minValue;
/* 递增值 */
@property (nonatomic, assign) NSUInteger incrementValue;

-(instancetype)initWithFrame:(CGRect)frame borderColor: (UIColor *) borderColor;

-(NSUInteger) getValue;

@end
