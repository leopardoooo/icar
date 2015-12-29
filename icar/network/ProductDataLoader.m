//
//  ProductDataLoader.m
//  icar
//
//  Created by Killer on 15/11/30.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductDataLoader.h"
#import "Settings.h"
#import "Pager.h"
#import "ProductResultModel.h"
#import "AFNetworking.h"
#import "DataLoaderUtils.h"

@implementation ProductDataLoader

+(void)queryProdList:(NSInteger)start
           withLimit:(NSInteger)limit
             success: (void (^)(Pager * page)) success
             failure: (void (^)(NSError *)) failure
                done: (void(^)(void)) done{
    
    NSDictionary *params = @{@"start": [NSNumber numberWithInteger:start], @"limit": [NSNumber numberWithInteger:limit]};
    
    [DataLoaderUtils julunHttpPost:sysHttpProduct_QueryList params:params parseHandler:^id(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 解析数据
        Pager *page = [[Pager alloc] init];
        [page setValuesForKeysWithDictionary: responseObject];
        
        NSMutableArray *records = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < page.records.count; i++) {
            NSDictionary *d = page.records[i];
            ProductResultModel *prm = [[ProductResultModel alloc] init];
            prm.prodName = d[@"fullName"];
            prm.prodPrice = [d[@"price"] floatValue];
            prm.commentCount = [d[@"evaluations"] integerValue];
            prm.prodImageUrl = d[@"listImageUrl"];
            [records addObject:prm];
        }
        page.records = records;
        
        return page;
    } success:success failure:failure done:done];
}

@end
