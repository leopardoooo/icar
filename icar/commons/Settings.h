//
//  PSMacro.h
//  icar
//
//  Created by Killer on 15/11/19.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

/*!
 系统有关的配置宏定义，比如IP、第三方APP Key等与业务无关且会因为环境的不同而修改的配置在该宏文件中定义
 定义时为了不与其它宏文件产生冲突，建议在宏定义都以sys(system)开头
 */

#ifndef icar_Settings_h
#define icar_Settings_h

// 系统版本号
#define sysVersion 0.0.1

/* 系统服务端URL，这仅仅是前面一部分的URL，完整的URL应该sysHttpServerPreffix + 具体的业务地址 */
#define sysHttpServerPreffix @"http://120.26.67.181:8088/icar/"
//#define sysHttpServerPreffix @"http://127.0.0.1:8080/icar-http/"

#pragma mark 产品相关的URI
// 查询产品可用产品
#define sysHttpProduct_QueryList @"data/prodList.jsp"

#pragma mark 购物车相关的URI
// 查询购物车列表
#define sysHttpCart_QueryList @"data/myCart.jsp"
// 查询我的消息
#define sysHttpCart_MyMessageList @"data/myMsg.jsp"


/* 系统是否是第一次启动的标志Key，该标志用于AppDelegate.m */
#define sysDefaultFirstLaunchKey @"firstLaunchKey"


#endif
