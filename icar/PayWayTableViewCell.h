//
//  PayWayTableViewCell.h
//  icar
//
//  Created by Killer on 15/11/26.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayWayModel.h"

@interface PayWayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *paySubTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkBox;

@property (strong, nonatomic) PayWayModel *payway;


// 设置单选状态
-(void)setCheckStateView: (BOOL) state;

@end
