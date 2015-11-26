//
//  ConfirmOrderViewController.h
//  icar
//
//  Created by Killer on 15/11/24.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 订单确认控制器
 */
@interface ConfirmOrderViewController : UIViewController

/**
 *  静态方法打开当前控制器
 */
+(void)open:(UIViewController *)target withData: (NSArray *) dataArray;

-(instancetype)initWithData: (NSArray *) dataArray;

@property (weak, nonatomic) IBOutlet UIView *bottomBarContentView;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalFee;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
