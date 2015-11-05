//
//  JLCarouselView.h
//  icar
//
//  Created by Killer on 15/11/5.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

/**
 该组件只复杂轮播组件基础功能，内容需要自己扩展，这里仅仅维护一个页数，
 自动轮播，滑动下一个视图，基于该组件可以实现图片的轮播，自定义内容的轮播
 */
#import <UIKit/UIKit.h>

@interface JLCarouselView : UIView


-(instancetype) initWithFrame:(CGRect)frame withPages:(NSInteger ) pages;

/**
 *  扩展的内容页，每次添加一张视图，当然不能超过给定的pages
 *
 *  @param singleView
 */
-(void)addToScrollView:(UIView *) singleView;


/* 启动一个定时轮播视图
 建议：在页面渲染时：viewWillAppear开启定时器
 在页面退出舞台时关闭定时器，以免在后台运行
 */
-(void)startTimer: (NSTimeInterval) interval;

-(void)stopTimer;

@end
