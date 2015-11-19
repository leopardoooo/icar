//
//  SplitLineLabelView.m
//  icar
//
//  Created by Killer on 15/11/18.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SplitLineLabelView.h"
#import "TemplateUtil.h"
#import "ViewUtils.h"
#import "UIView+Border.h"
#import "MacroDefine.h"

@implementation SplitLineLabelView


-(instancetype)initWithFrame:(CGRect)frame withTitle: (NSString *) title bgColor: (UIColor *) bgColor lineColor: (UIColor *) lineColor titleColor: (UIColor *) titleColor{
    if(self = [super initWithFrame:frame]){
        //Label
        CGSize titleSize = [ViewUtils sizeWithSingleLine:title fontSize:13];
        CGFloat width = titleSize.width + 30;
        UILabel *label = [TemplateUtil label:title fontSize:13 color:titleColor frame: CGRectMake((frame.size.width - width)/2, 0, width, frame.size.height)];
        label.backgroundColor = bgColor;
        label.textAlignment = NSTextAlignmentCenter;
        
        // split line
        CGFloat poxy = (frame.size.height - .6) / 2.0 ;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, poxy, frame.size.width, .6)];
        lineView.backgroundColor = lineColor;
        [lineView addBottomBorderWithColor:THEME_WHITE_COLOR andWidth:.5];
        
        [self addSubview:lineView];
        [self addSubview:label];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
