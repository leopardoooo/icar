//
//  CountInputView.m
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "CountInputView.h"
#import "TemplateUtil.h"
#import "MacroDefine.h"
#import "ViewUtils.h"

@implementation CountInputView

-(instancetype)initWithFrame:(CGRect)frame borderColor: (UIColor *) borderColor{
    if(self = [super initWithFrame:frame]){
        // 设置默认值
        _minValue = 1;
        _maxValue = 10;
        _incrementValue = 1;
        
        CGFloat radius = 3.0;
        CGFloat width = frame.size.width / 3.0;
        
        // minus button
        _minusBtn = [TemplateUtil button:@"-" fontSize:20 color:THEME_COLOR_NORMAL_OBJ frame:CGRectMake(0, 0, width, frame.size.height) radius:radius border:1 borderColor:borderColor bgColor:THEME_WHITE_COLOR];
        _minusBtn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
        [_minusBtn addTarget:self action:@selector(didMinusClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // input
        _countField = [[UITextField alloc] initWithFrame:CGRectMake(width-radius, 0, width+radius*2, frame.size.height)];
        _countField.keyboardType = UIKeyboardTypeNumberPad;
        _countField.text = @"1";
        _countField.backgroundColor = THEME_WHITE_COLOR;
        _countField.layer.borderColor = borderColor.CGColor;
        _countField.textAlignment = NSTextAlignmentCenter;
        _countField.layer.borderWidth = 1;
        _countField.userInteractionEnabled = NO;
        
        // plus button
        _plusBtn = [TemplateUtil button:@"+" fontSize:20 color:THEME_COLOR_NORMAL_OBJ frame:CGRectMake(width * 2, 0, width, frame.size.height) radius:radius border:1.0 borderColor:borderColor bgColor:THEME_WHITE_COLOR];
        _plusBtn.titleEdgeInsets = UIEdgeInsetsMake(-2, radius / 2, 0, 0);
        [_plusBtn addTarget:self action:@selector(didPlusClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_minusBtn];
        [self addSubview:_plusBtn];
        [self addSubview:_countField];
    }
    return self;
}

-(void)didMinusClick: (id) sender{
    [self calcCounter: -_incrementValue];
}

-(void)didPlusClick: (id) sender{
    [self calcCounter:_incrementValue];
}

-(void)calcCounter: (NSUInteger) value{
    NSUInteger currentValue = [_countField.text longLongValue];
    NSUInteger newValue = currentValue + value;

    // 超过阀值
    if((int)(newValue - _minValue) < 0){
        return ;
    }
    if(_maxValue && (int)(newValue - _maxValue) > 0){
        return ;
    }
    _countField.text = [NSString stringWithFormat:@"%ld",newValue];
}

-(NSUInteger) getValue{
    return [_countField.text longLongValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
