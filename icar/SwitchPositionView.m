//
//  SwitchPositionView.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SwitchPositionView.h"
#import "MacroDefine.h"
#import "HomeViewController.h"

@interface SwitchPositionView (){
    UIView *_bodyView;
    HomeViewController *_homeVC;
}

@end

@implementation SwitchPositionView

-(instancetype) initWithFrame:(CGRect)frame withParent: (HomeViewController *) homeVC{
    if(self = [super initWithFrame:frame]){
        [self createModelWindow];
        [self addPositionCities];
        [self addOpenedCities];
        
        _homeVC = homeVC;
    }
    
    return self;
}

-(void)createModelWindow{
    _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    _bodyView.backgroundColor = [UIColor colorWithWhite:0.950 alpha:.9];
    _bodyView.layer.masksToBounds = YES;
    _bodyView.layer.cornerRadius = 2;
    
    
    [self addSubview:_bodyView];
}

-(void)addPositionCities{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, _bodyView.frame.size.width - 30, 20)];
    title.text = @"当前定位城市";
    title.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    title.font = [UIFont systemFontOfSize:14];
    
    UIButton *btn = [self createUIButton:@"杭州" withCGPoint:CGPointMake(15, 45) withTag: 10000];
    btn.backgroundColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 0;
    [_bodyView addSubview: title];
    [_bodyView addSubview:btn];
}

-(void)addOpenedCities{
    NSArray *cities = @[@"杭州",@"西安"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, _bodyView.frame.size.width - 30, 20)];
    title.text = @"已开通城市";
    title.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    title.font = [UIFont systemFontOfSize:14];
    [_bodyView addSubview: title];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 110, _bodyView.frame.size.width, 100)];
    int padding = 15, w = 100;
    for (int i = 0; i< cities.count; i++){
        UIButton *btn = [self createUIButton:cities[i] withCGPoint:CGPointMake(padding * (i + 1) + w * i, padding) withTag:i];
        [view addSubview: btn];
    }
    
    [_bodyView addSubview:view];
}

-(UIButton *) createUIButton:(NSString *) title withCGPoint: (CGPoint) point withTag: (NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle: title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
    btn.frame = CGRectMake(point.x , point.y, 100, 38);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor colorWithWhite:0.902 alpha:1.000] CGColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    btn.backgroundColor = [UIColor whiteColor];
    btn.tag = tag;
    
    [btn addTarget:self action:@selector(togglePosition:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)togglePosition:(UIButton *) btn{
    _homeVC.posLabel.text = btn.titleLabel.text;
    [self hide];
}

-(void)hide:(float)duration{
    if(self.showState){
        [UIView animateWithDuration:duration animations:^{
            [self setBodyFrame:0];
        }];
        [super hide:duration];
        [_homeVC.posImageView setHighlighted:NO];
    }
}

-(void)show:(float)duration{
    if(!self.showState){
        [UIView animateWithDuration:duration animations:^{
            [self setBodyFrame:200];
        }];
        [super show:duration];
        [_homeVC.posImageView setHighlighted:YES];
    }
}
-(void)setBodyFrame:(float) height{
     _bodyView.frame = CGRectMake(5, 5, self.frame.size.width - 10, height);
}


@end
