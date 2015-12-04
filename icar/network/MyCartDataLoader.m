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

#define HTTP_QUERY_MYCART @"%@data/myCart.jsp"

@implementation MyCartDataLoader


+(void)queryMyCartWithHandler: (void (^)(NSMutableArray * data)) handler{
    // 生成URL
    NSString *urlString = [NSString stringWithFormat:HTTP_QUERY_MYCART, HTTP_SERVER_PREFFIX, nil];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            NSLog(@"网络繁忙，请稍后再试！");
            return;
        }
        
        // 解析JSON数据
        NSError *jsonError = nil;
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error: &jsonError];
        if(jsonError){
            NSLog(@"Json转换异常：%@", [jsonError localizedDescription]);
            return ;
        }
        
        NSMutableArray *records = [[NSMutableArray alloc] init];
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
        
        // 调用回调函数
        if(handler){
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(records);
            });
        }
    }];
}
@end
