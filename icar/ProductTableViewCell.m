//
//  ProductTableVeiwCell.m
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "MacroDefine.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.markImageView.hidden = YES;
    [_priceLabel setTextColor: THEME_COLOR_HIGHLIGHTED_OBJ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
