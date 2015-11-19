//
//  FlowLayoutView.h
//  icar
//
//  Created by Killer on 15/11/16.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowLayoutView : UIView

-(instancetype)initWithFrame:(CGRect)frame hpadding: (CGFloat) hpadding vpadding: (CGFloat) vpadding startPosx: (CGFloat) startPositionX;

// 调整当前视图需要的高度，并且返回当前的视图的高度
-(CGFloat)adjustAutoHeight;

-(CGFloat) getAutoHeight;

@end
