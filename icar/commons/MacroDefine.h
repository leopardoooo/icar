//
//  MacroDefine.h
//  icar
//
//  Created by Killer on 15/11/3.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

// 默认高亮的字体颜色
#define THEME_COLOR_HIGHLIGHTED_OBJ [UIColor colorWithRed:0.143 green:0.673 blue:0.620 alpha:1.000]
// 默认的字体颜色
#define THEME_COLOR_NORMAL_OBJ [UIColor colorWithWhite:0.335 alpha:1.000]
// 默认的导航条背景颜色
#define THEME_NAVBAR_DFAULT_TINTCOLOR_OBJ [UIColor colorWithWhite:0.968 alpha:1.000]
// 默认的标题颜色，灰色系列
#define THEME_DFAULT_TITLE_COLOR_OBJ [UIColor colorWithWhite:0.372 alpha:1.000]
// 默认的边框颜色
#define THEME_COLOR_BORDER_OBJ [UIColor colorWithWhite:0.910 alpha:1.000]
// 默认的橘黄色亮色
#define THEME_COLOR_HIGHLIGHTED_ORAGE_OBJ [UIColor colorWithRed:1.000 green:0.500 blue:0.000 alpha:1.000]
// 透明颜色
#define THEME_CLEAR_COLOR [UIColor clearColor]
// 白色
#define THEME_WHITE_COLOR [UIColor whiteColor]
// 空图片
#define UIIMAGE_NONE [[UIImage alloc] init]


// 当前视图
#define SELF_SIZE_WIDTH self.view.frame.size.width
#define SELF_SIZE_HEIGHT self.view.frame.size.height
#define SELF_NAVBAR self.navigationController.navigationBar

// 屏幕大小
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 状态栏的SIZE
#define APP_STATUSBAR_SIZE [[UIApplication sharedApplication] statusBarFrame].size

// 系统版本大于或等于给定的版本号
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending);

// 系统版本小于给定的版本号
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending);

// IOS7.0版本
#define iOS7_0 @"7.0";


@interface MacroDefine : NSObject

@end
