//
//  ModelWindowView.h
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelWindowView : UIView

@property(nonatomic, assign) BOOL showState;

/**
 *  隐藏当前当前模态窗口
 */
-(void)hide;
-(void)hide: (float) duration;

-(void)show;
-(void)show:(float) duration;

-(void)toggle;
-(void)toggle:(float) duration;

@end
