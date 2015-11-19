//
//  ChooseProductView.m
//  icar
//
//  Created by Killer on 15/11/19.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ChooseProductView.h"
#import "ViewUtils.h"
#import "TemplateUtil.h"
#import "MacroDefine.h"

#define CHOOSE_PRODUCT_VIEW_HEIGHT 300

@interface ChooseProductView(){
    UIView * _bodyView;
    UIView * _maskView;
    UILabel *_countValue;
}
@end

@implementation ChooseProductView


+(void)showChooseProductWindow{
    ChooseProductView *_view = [[ChooseProductView alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_view];
    [_view showCurrentView];
}

-(instancetype)init{
    CGFloat poxy = APP_STATUSBAR_SIZE.height;
    CGRect mainRect = CGRectMake(0, poxy, SCREEN_WIDTH, SCREEN_HEIGHT - poxy);
    if(self = [super initWithFrame:mainRect]){
        // 遮罩视图
        _maskView = [[UIView alloc]initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCurrentViewFromSuperView)]];
        [self addSubview:_maskView];
        
        // 内容视图
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, CHOOSE_PRODUCT_VIEW_HEIGHT)];
        _bodyView.backgroundColor = THEME_WHITE_COLOR;
        [self addSubview:_bodyView];
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    UILabel *countLabel = [TemplateUtil label:@"数量" fontSize:15 color:THEME_COLOR_NORMAL_OBJ frame:CGRectMake(15, 15, 70, 30)];
    UIStepper *countStepper = [[UIStepper alloc]initWithFrame:CGRectMake(100, 15, 100, 60)];
    countStepper.tintColor = THEME_COLOR_HIGHLIGHTED_ORAGE_OBJ;
    countStepper.maximumValue = 100;
    countStepper.minimumValue = 1;
    [countStepper addTarget:self action:@selector(updateCountValue:) forControlEvents:UIControlEventValueChanged];
    _countValue = [TemplateUtil label:@"1" fontSize:15 color:[UIColor blackColor] frame:CGRectMake(200, 15, 70, 30)];
    
    [_bodyView addSubview:countLabel];
    [_bodyView addSubview:countStepper];
    [_bodyView addSubview:_countValue];
    
    UIButton *okBtn = [TemplateUtil button:@"确定" fontSize:15 color:THEME_WHITE_COLOR frame:CGRectMake(0, CHOOSE_PRODUCT_VIEW_HEIGHT - 40, SCREEN_WIDTH, 40) radius:0 border:0 borderColor:nil bgColor:THEME_COLOR_HIGHLIGHTED_ORAGE_OBJ];
    [_bodyView addSubview:okBtn];
    
    [okBtn addTarget:self action:@selector(okAndRemoveFromSubView:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateCountValue: (UIStepper *) stepper{
    _countValue.text = [NSString stringWithFormat:@"%.0f", stepper.value];
}

-(void)okAndRemoveFromSubView: (id)sender{
    [self hideCurrentViewFromSuperView];
}

-(void)showCurrentView{
    CGFloat posy = SCREEN_HEIGHT - APP_STATUSBAR_SIZE.height -CHOOSE_PRODUCT_VIEW_HEIGHT;
    [UIView animateWithDuration:.3 animations:^{
        _bodyView.frame = CGRectMake(0, posy, SCREEN_WIDTH, CHOOSE_PRODUCT_VIEW_HEIGHT);
        _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    }];
}

-(void)hideCurrentViewFromSuperView{
    [UIView animateWithDuration:.3 animations:^{
        _bodyView.frame = CGRectMake(0, SCREEN_HEIGHT - APP_STATUSBAR_SIZE.height, _bodyView.frame.size.width, _bodyView.frame.size.height);
        _maskView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
