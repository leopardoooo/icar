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

/* 系统服务端URL，这仅仅是前面一部分的URL，完整的URL应该HTTP_SERVER_PREFFIX + 具体的业务地址 */
#define HTTP_SERVER_PREFFIX @"http://120.26.67.181:8088/icar/"

#endif
