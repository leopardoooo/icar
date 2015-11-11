//
//  MixedUtils.h
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 大杂烩工具类，包含各类型的工具方法，如数据，字符串处理等
 */
@interface MixedUtils : NSObject

/**
 *  生成随机数，在指定的区间内
 */
+(int)getRandomNumber:(int)from to:(int)to;

@end
