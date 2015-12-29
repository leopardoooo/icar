//
//  TipNetworkErrorView.h
//  icar
//
//  Created by Killer on 15/12/8.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipMessageView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

// 实例化一个网络错误的视图
+(TipMessageView *) instanceNetworkErrorView: (UIView *) parentView;

// 创建一个无订单的消息视图
+(TipMessageView *) instanceEmptyOrderView: (UIView *) parentView;

+(TipMessageView *) instanceEmptyMessageView: (UIView *) parentView title: (NSString *) title subTitle: (NSString *) subTitle buttonText: (NSString *) btnText;

@end
