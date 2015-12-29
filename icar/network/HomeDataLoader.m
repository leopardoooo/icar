//
//  HomeDataLoader.m
//  icar
//
//  Created by Killer on 15/12/7.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "HomeDataLoader.h"
#import "NavigationItemModel.h"

@implementation HomeDataLoader

+(NSArray *) findNavItems{
    
    NSMutableArray *target = [[NSMutableArray alloc] init];
    
    NavigationItemModel *item1 = [[NavigationItemModel alloc] init];
    item1.iconUrl = @"home_cz";
    item1.iconTitle = @"充值中心";
    [target addObject:item1];
    
    NavigationItemModel *item2 = [[NavigationItemModel alloc] init];
    item2.iconUrl = @"home_dd";
    item2.iconTitle = @"淘点点";
    [target addObject:item2];
    
    NavigationItemModel *item4 = [[NavigationItemModel alloc] init];
    item4.iconUrl = @"home_jhs";
    item4.iconTitle = @"聚划算";
    [target addObject:item4];
    
    NavigationItemModel *item5 = [[NavigationItemModel alloc] init];
    item5.iconUrl = @"home_qua";
    item5.iconTitle = @"去啊";
    [target addObject:item5];
    
    NavigationItemModel *item6 = [[NavigationItemModel alloc] init];
    item6.iconUrl = @"home_tjb";
    item6.iconTitle = @"淘金币";
    [target addObject:item6];
    
    NavigationItemModel *item7 = [[NavigationItemModel alloc] init];
    item7.iconUrl = @"home_tmcs";
    item7.iconTitle = @"天猫超市";
    [target addObject:item7];
    
    NavigationItemModel *item8 = [[NavigationItemModel alloc] init];
    item8.iconUrl = @"home_tsh";
    item8.iconTitle = @"淘生活";
    [target addObject:item8];
    
    NavigationItemModel *item3 = [[NavigationItemModel alloc] init];
    item3.iconUrl = @"home_fl";
    item3.iconTitle = @"分类";
    [target addObject:item3];
    
    return target;
}

@end
