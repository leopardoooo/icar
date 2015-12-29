//
//  MyMessageModel.h
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessageModel : NSObject

@property (nonatomic, strong) NSString *msgTitle;
@property (nonatomic, strong) NSString *msgDesc;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, assign) BOOL readedMark;
@property (nonatomic, strong) NSString *msgType;

@end
