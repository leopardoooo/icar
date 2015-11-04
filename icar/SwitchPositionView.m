//
//  SwitchPositionView.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SwitchPositionView.h"
#import "MacroDefine.h"

@interface SwitchPositionView (){
    UIView *_bodyView;
}

@end

@implementation SwitchPositionView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createModelWindow];
    }
    
    return self;
}

-(void)createModelWindow{
    _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    _bodyView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
   // _bodyView.layer.masksToBounds = YES;
   // _bodyView.layer.cornerRadius = 2;
    
    [self addSubview:_bodyView];
}

-(void)hide:(float)duration{
    [super hide:duration];
    [self setBodyFrame: 0];
}

-(void)show:(float)duration{
    [super show:duration];
    [UIView animateWithDuration:duration animations:^{
        [self setBodyFrame:300];
    }];
}
-(void)setBodyFrame:(float) height{
     _bodyView.frame = CGRectMake(0, 0, self.frame.size.width, height);
}


@end
