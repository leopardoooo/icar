//
//  ViewUtils.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ViewUtils.h"
#import "MacroDefine.h"
#import "MBProgressHUD.h"
#import "TemplateUtil.h"

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
+(void)showAnyIconMessage: (JLMessageIconType) iconType withMessage:(NSString *) message{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
   
    if(iconType == JLMessageIconTypeLoading){
    }else{
        NSString *imageNamed = @"";
        switch (iconType) {
            case JLMessageIconTypeInfo:
            case JLMessageIconTypeWarn:
            case JLMessageIconTypeCompleted:
            case JLMessageIconTypeError:
            default:
            {
                imageNamed = @"37x-Checkmark";
            }
                break;
        }
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        hud.mode = MBProgressHUDModeCustomView;
    }
    hud.square = YES;
    
    hud.labelText = message;
    //hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

/**
 *  自动消失提示信息
 */
+(void)showTextMessage: (NSString *) message{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

@end

