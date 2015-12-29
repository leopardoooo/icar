//
//  DataLoaderUtils.m
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "DataLoaderUtils.h"
#import "AFNetworking.h"
#import "Settings.h"
#import "ViewUtils.h"

@implementation DataLoaderUtils

+(void)julunHttpPost:(NSString *)uri
              params:(id)params
        parseHandler:(id (^)(AFHTTPRequestOperation *, id))handler
             success:(void (^)(id))success
             failure:(void (^)(NSError *))failure
                done:(void (^)(void))done{
    // 生成URL
    NSString *urlString = [sysHttpServerPreffix stringByAppendingPathComponent:uri];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 解析数据
        id targetData = handler(operation, responseObject);
        
        // 调用回调函数
        dispatch_async(dispatch_get_main_queue(), ^{
            success(targetData);
            if(done){
                done();
            }
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Http请求发生错误：%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ViewUtils showTextMessage: [NSString stringWithFormat:@"%@", error.localizedDescription]];
            if(failure){
                failure(error);
            }
            if(done){
                done();   
            }
        });
    }];
}
@end
