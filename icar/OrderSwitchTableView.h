//
//  OrderSwitchTableView.h
//  icar
//
//  Created by Killer on 15/11/10.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelWindowView.h"

@interface OrderSwitchTableView : ModelWindowView

@property(nonatomic, readonly, retain) id currentData;

-(instancetype)initWithData:(NSArray *) dataArray withTarget: (UIButton *) target;

@end
