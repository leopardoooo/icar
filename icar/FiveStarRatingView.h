//
//  FiveStarView.h
//  icar
//
//  Created by Killer on 15/11/12.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiveStarRatingView : UIView

-(instancetype)initWithPoint: (CGPoint) point withStarSize: (CGSize) size withRatio: (CGFloat) ratio;

/**
 *  设置评分值
 *
 *  @param ratio 评分值介于0 - 1之间的浮点数
 *  @param isAnimate  是否播放动画
 *  @param completion 完成的动画Block
 */
-(void)setRatingValue: (CGFloat) ratio animate:(BOOL) isAnimate completion: (void (^)(BOOL finished)) completion;



@end
