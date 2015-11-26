//
//  PayWayModel.h
//  icar
//
//  Created by Killer on 15/11/26.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WEIXIN,
    ALIPAY
} PayWay ;

@interface PayWayModel : NSObject

// 实体属性
@property (assign, nonatomic) PayWay payway;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *iconNamed;

@end
