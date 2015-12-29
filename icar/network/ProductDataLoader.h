//
//  ProductDataLoader.h
//  icar
//
//  Created by Killer on 15/11/30.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pager.h"

@interface ProductDataLoader : NSObject

// 查询产品列表，分页查询
+(void)queryProdList:(NSInteger)start
           withLimit:(NSInteger)limit
             success: (void (^)(Pager * page)) success
             failure: (void (^)(NSError * error)) failure
                done: (void(^)(void)) done;

@end
