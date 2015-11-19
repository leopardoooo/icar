//
//  FlowLayoutView.m
//  icar
//
//  Created by Killer on 15/11/16.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "FlowLayoutView.h"


@interface FlowLayoutView (){
    // setting properies
    // 水平间距
    CGFloat _hpadding;
    // 垂直间距
    CGFloat _vpadding;
    
    // inner class properties
    CGFloat _lastLabelY;
    CGFloat _lastLabelX;
    // 当前一行最高视图的高度
    CGFloat _lastHeight;
}

@end

// 流式布局视图
@implementation FlowLayoutView

-(instancetype)initWithFrame:(CGRect)frame hpadding: (CGFloat) hpadding vpadding: (CGFloat) vpadding startPosx: (CGFloat) startPositionX{
    if(self = [super initWithFrame:frame]){
        _hpadding = hpadding;
        _vpadding = vpadding;
        
        _lastLabelX = startPositionX;
        _lastHeight = .0;
    }
    return self;
}

- (void) addSubview:(UIView *)view{
    if(!view){ return; }
    // 获得宽度高度
    CGSize size = view.frame.size;
    // 检查余下的宽度是否足够
    if(_lastLabelX + size.width + _hpadding > self.frame.size.width){
        _lastLabelY += _lastHeight + _vpadding;
        _lastLabelX = 15;
        _lastHeight = .0;
    }
    
    // 重新设置view的frame
    view.frame = CGRectMake(_lastLabelX, _lastLabelY, size.width, size.height);
    [super addSubview: view];
    
    _lastLabelX += size.width + _hpadding;
    if(_lastHeight < size.height){
        _lastHeight = size.height;
    }
}

// 调整当前视图需要的高度，并且返回当前的视图的高度
-(CGFloat)adjustAutoHeight{
    CGFloat height = [self getAutoHeight];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    
    return height;
}

-(CGFloat) getAutoHeight{
    return _lastLabelY + _lastHeight + _vpadding;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
