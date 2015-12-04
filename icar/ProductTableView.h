//
//  ProductTableView.h
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableView : UITableView

@property(nonatomic, strong) NSMutableArray * dataArray;

-(instancetype)initWithFrame:(CGRect)frame parent: (UIViewController *) parent;

// 首次加载数据
-(void) firstLoadTableData;

@end
