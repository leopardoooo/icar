//
//  Pager.h
//  icar
//
//  Created by Killer on 15/11/30.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pager : NSObject
// 当前页显示的数据
@property (nonatomic, strong) NSMutableArray *records;
// 开始位置
@property (nonatomic, assign) NSInteger start;
// 每页显示的条数
@property (nonatomic, assign) NSInteger limit;
// 总条数
@property (nonatomic, assign) NSInteger totalCount;

@end
