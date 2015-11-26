//
//  ShoppingCartTableViewCell.h
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
#import "ShoppingCartViewController.h"

@interface ShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *prodImageView;
@property (weak, nonatomic) IBOutlet UIImageView *radioImageView;
@property (weak, nonatomic) IBOutlet UILabel *prodTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *prodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;
@property (weak, nonatomic) IBOutlet UIView *prodInfoContentView;

// 编辑信息outlet
@property (weak, nonatomic) IBOutlet UIView *editInfoContentView;
@property (weak, nonatomic) IBOutlet UIButton *editMinusBtn;
@property (weak, nonatomic) IBOutlet UIButton *editCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *editPlusBtn;
@property (weak, nonatomic) IBOutlet UILabel *editSelectedDescLabel;


// 需要传入父视图
@property (weak, nonatomic) ShoppingCartViewController *parent;

-(void)loadCellDataWithShoppingCartModel: (ShoppingCartModel *) scm;


@end
