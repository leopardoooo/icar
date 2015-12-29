//
//  MyCartDataLoader.m
//  icar
//
//  Created by Killer on 15/11/23.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "MyCartDataLoader.h"
#import "ShoppingCartModel.h"
#import "Settings.h"
#import "DataLoaderUtils.h"
#import "MyMessageModel.h"



@implementation MyCartDataLoader


+(void)queryMyCart: (void (^)(NSMutableArray * data)) success
           failure: (void (^)(NSError *)) failure
              done: (void (^)(void)) done{
    [DataLoaderUtils julunHttpPost:sysHttpCart_QueryList params:nil parseHandler:^id(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 解析数据
        NSMutableArray *records = [[NSMutableArray alloc] init];
        NSArray *dataArray = responseObject;
        for (int i = 0 ; i < dataArray.count; i++) {
            NSDictionary *d = dataArray[i];
            ShoppingCartModel *scm = [[ShoppingCartModel alloc] init];
            scm.prodName = d[@"prodName"];
            scm.prodId = [d[@"prodId"] integerValue];
            scm.prodCartImage = d[@"prodImageUrl"];
            scm.buyPrice = [d[@"buyPrice"] floatValue];
            scm.prodMarketPrice = [d[@"marketPrice"] floatValue];
            scm.buyCount = [d[@"buyCount"] intValue];
            scm.selectedDesc = d[@"selectedDesc"];
            
            [records addObject:scm];
        }
        
        return records;
    } success:success failure:failure done:done];
}

+(void)queryMyMessage: (void (^)(NSMutableArray * data)) success
           failure: (void (^)(NSError *)) failure
              done: (void (^)(void)) done{
    [DataLoaderUtils julunHttpPost:sysHttpCart_MyMessageList params:nil parseHandler:^id(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 解析数据
        NSMutableArray *records = [[NSMutableArray alloc] init];
        NSArray *dataArray = responseObject;
        for (int i = 0 ; i < dataArray.count; i++) {
            NSDictionary *d = dataArray[i];
            MyMessageModel *mm = [[MyMessageModel alloc] init];
            mm.msgTitle = d[@"msgTitle"];
            mm.msgDesc = d[@"msgDesc"];
            mm.pubDate = d[@"pubDate"];
            mm.iconUrl = d[@"iconUrl"];
            mm.readedMark = [d[@"readedMask"] boolValue];
            
            [records addObject:mm];
        }
        
        return records;
    } success:success failure:failure done:done];
}
@end
