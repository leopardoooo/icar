//
//  AppNavigationController.h
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppNavigationController : UINavigationController


/**
 *  将系统导航的默认样式，通常比如一个APP首页的导航栏会比较个性化，而其它则比较普通，那只有在具有个性控制器中设置样式即可，其它的控制器将继续采用默认的风格
 */
-(void)resetAppBarStyle;

@end
