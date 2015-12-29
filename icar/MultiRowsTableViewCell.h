//
//  MultiRowsTableViewCell.h
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiRowsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *msgImageView;
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *readMarkImageView;

@end
