//
//  PayViewController.h
//  icar
//
//  Created by Killer on 15/11/26.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topBarContentView;
@property (weak, nonatomic) IBOutlet UILabel *payAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *payWayTableView;


+(void)open:(UIViewController *)target;

@end
