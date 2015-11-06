//
//  ModelWindowView.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ModelWindowView.h"

@interface ModelWindowView (){
}

@end


@implementation ModelWindowView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:.5];
        self.alpha = 0;
    }
        
    return self;
}

#pragma mark 实现接口方法
-(void)hide{
    [self hide:0.3];
}
-(void)hide: (float) duration{
    if(self.showState){
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 0;
        }];
        self.showState = NO;
    }
}

-(void)show{
    [self show:0.3];
}
-(void)show:(float)duration{
    if(!self.showState){
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 1;
        }];
        self.showState = YES;
    }
}

-(void)toggle{
    [self toggle:0.3];
}
-(void)toggle:(float) duration{
    if(_showState == NO){
        [self show];
    }else{
        [self hide];
    }
}

#pragma mark 触摸屏幕到当前视图隐藏当前视图
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hide];
}
@end
