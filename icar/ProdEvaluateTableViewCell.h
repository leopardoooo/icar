//
//  ProdEvaluateTableViewCell.h
//  icar
//
//  Created by Killer on 15/11/12.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiveStarRatingView.h"

@interface ProdEvaluateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *starRatingParentView;

@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIView *shareImageParentView;

@end
