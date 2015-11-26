//
//  ViewUtils.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ViewUtils.h"
#import "MacroDefine.h"

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

+(void) viewAnyRadius: (UIView *) target any: (UIRectCorner) any radius: (CGSize) size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:target.bounds byRoundingCorners:any cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = target.bounds;
    maskLayer.path = maskPath.CGPath;
    target.layer.mask = maskLayer;
}

/**
 *  单号文本的行高和宽度
 */
+(CGSize) sizeWithSingleLine: (NSString *) labelText fontSize: (CGFloat) fontSize{
    return [labelText sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
}

/**
 *  多行文本，求高度
 */
+(CGSize) sizeWithLines: (NSString *) labelText fontSize: (CGFloat) fontSize width: (CGFloat) width{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize] };
    return [labelText boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options: NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 *  自动消失提示框
 */
+(void)showMessage:(NSString *)message{
    CGSize labelSize = [self sizeWithSingleLine:message fontSize:17];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = .8f;
    showview.layer.cornerRadius = 16;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    CGRect rect=[[UIScreen mainScreen] bounds];
    showview.frame = CGRectMake((rect.size.width - labelSize.width - 20)/2, rect.size.height - 100, labelSize.width+20, labelSize.height+10);
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end

