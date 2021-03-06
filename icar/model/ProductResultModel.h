//
//  SearchProductResultModel.h
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductResultModel : NSObject

@property(nonatomic, retain) NSString *prodName;
@property(nonatomic, assign) float prodPrice;
@property(nonatomic, assign) long commentCount;
@property(nonatomic, retain) NSString *prodImageUrl;

@end
