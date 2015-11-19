//
//  ProdEvaluateTableViewCell.m
//  icar
//
//  Created by Killer on 15/11/12.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProdEvaluateTableViewCell.h"
#import "FiveStarRatingView.h"

@implementation ProdEvaluateTableViewCell

- (void)awakeFromNib {
    self.shareImageParentView.backgroundColor = [UIColor clearColor];
    self.starRatingParentView.backgroundColor = [UIColor clearColor];
    [self.starRatingParentView awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
