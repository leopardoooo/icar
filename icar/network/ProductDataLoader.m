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

#define HTTP_QUERY_PROD_LIST @"%@data/prodList.jsp?start=%ld&limit=%ld"

@implementation ProductDataLoader

+(void)queryProdList:(NSInteger)start withLimit:(NSInteger)limit success: (void (^)(Pager * page)) success
    failure: (void (^)(void)) failure {
    // 生成URL
    NSString *urlString = [NSString stringWithFormat:HTTP_QUERY_PROD_LIST, HTTP_SERVER_PREFFIX, start, limit, nil];
    
    NSDictionary *params = @{@"start": [NSNumber numberWithInteger:start], @"limit": [NSNumber numberWithInteger:limit]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
        // 调用回调函数
        dispatch_async(dispatch_get_main_queue(), ^{
            success(page);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure();
        });
    }];
}

@end
