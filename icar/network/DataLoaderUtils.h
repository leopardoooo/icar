//
//  DataLoaderUtils.h
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface DataLoaderUtils : NSObject

// 这是一个POST模板方法
+(void)julunHttpPost: (NSString *) uri
              params: (id) params
        parseHandler: (id (^)(AFHTTPRequestOperation * operation,               id responseObject)) handler
             success: (void (^)(id responseObject)) success
             failure: (void (^)(NSError * error)) failure
                done: (void (^)(void))done;

@end
