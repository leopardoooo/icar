//
//  SplitCategoryView.m
//  icar
//
//  Created by Killer on 15/11/10.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SplitCategoryView.h"
#import "MacroDefine.h"
#import "ViewUtils.h"

@interface SplitCategoryView(){
    
    UIButton * _target;
}

@end

@implementation SplitCategoryView

-(instancetype)initWithTarget: (UIButton *) target{
    if(self = [self initWithFrame: CGRectMake(0, 36, SCREEN_WIDTH,SCREEN_HEIGHT)]){
        _target = target;
        
        [self createBodyView];
    }
    return self;
}

-(void)createBodyView{
    
    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 260)];
    bodyView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bodyView];
}

-(void)show:(float)duration{
    [super show:duration];
    
    [_target setTitleColor:THEME_COLOR_HIGHLIGHTED_OBJ forState:UIControlStateNormal];
}
-(void)hide:(float)duration{
    [super hide:duration];
    [_target setTitleColor:THEME_COLOR_NORMAL_OBJ forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
