//
//  TipNetworkErrorView.m
//  icar
//
//  Created by Killer on 15/12/8.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "TipMessageView.h"
#import "Resources.h"

@implementation TipMessageView

+(TipMessageView *) instanceNetworkErrorView: (UIView *) parentView{
    TipMessageView *msgView = RES_GetObj_TipNetworkErrorView;
    msgView.frame = parentView.bounds;
    
    [parentView addSubview:msgView];
    return msgView;
}

+(TipMessageView *) instanceEmptyMessageView: (UIView *) parentView title: (NSString *) title subTitle: (NSString *) subTitle buttonText: (NSString *) btnText{
    TipMessageView *msgView = RES_GetObj_TipNetworkErrorView;
    msgView.frame = parentView.bounds;
    
    msgView.tipImageView.image = [UIImage imageNamed:@"order_list_empty_icon"];
    msgView.titleLabel.text = title;
    msgView.subTitleLabel.text = subTitle;
    [msgView.reloadBtn setTitle:btnText forState:UIControlStateNormal];
    
    [parentView addSubview:msgView];
    return msgView;
}

+(TipMessageView *) instanceEmptyOrderView: (UIView *) parentView{
    return [TipMessageView instanceEmptyMessageView:parentView title:@"您还没有相关订单" subTitle:@"点击按钮去商城购买" buttonText:@"商城购买"];
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.reloadBtn.layer.borderWidth = 1;
    self.reloadBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.reloadBtn.layer.cornerRadius = 3.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
