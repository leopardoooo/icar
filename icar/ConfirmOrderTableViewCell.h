//
//  ConfirmOrderTableViewCell.h
//  icar
//
//  Created by Killer on 15/11/24.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

#define ConfirmOrderTableViewCell_ROW_HEIGHT 40

@interface ConfirmOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *prodImageView;
@property (weak, nonatomic) IBOutlet UILabel *prodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *prodSelectedDescLabel;
@property (weak, nonatomic) IBOutlet UIView *prodInfoContentView;
@property (weak, nonatomic) IBOutlet UILabel *subTotalFeeLabel;


-(void)loadCellWithData: (ShoppingCartModel *) scm;

@end
