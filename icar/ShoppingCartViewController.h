//
//  ShoppingCartViewController.h
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartViewController : UIViewController
// 结算工具条视图（父视图）
@property (weak, nonatomic) IBOutlet UIView *payToolBarView;
// 总金额视图
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
// 结算按钮
@property (weak, nonatomic) IBOutlet UIButton *settleBtn;
// 全选按钮
@property (weak, nonatomic) IBOutlet UIButton *selectedAllBox;
@property (weak, nonatomic) IBOutlet UILabel *selectedAllLabel;

// “合计” 文字视图，为了隐藏
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalView;


// 加入收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *joinCollectBtn;
// 删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteCheckedBtn;

//根据当前选中状态重新计算结算金额
-(void)doResetTotalFee;

@end
