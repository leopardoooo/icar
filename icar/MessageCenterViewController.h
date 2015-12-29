//
//  MessageCenterViewController.h
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCenterViewController : UIViewController

+(void)open:(UIViewController *)target;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
