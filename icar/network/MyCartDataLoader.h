//
//  MyCartDataLoader.h
//  icar
//
//  Created by Killer on 15/11/23.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCartDataLoader : NSObject


// 查询我的购物车清单
+(void)queryMyCartWithHandler: (void (^)(NSMutableArray * data)) handler;

@end
