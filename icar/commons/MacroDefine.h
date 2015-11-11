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

#define SELF_SIZE_WIDTH self.view.frame.size.width
#define SELF_SIZE_HEIGHT self.view.frame.size.height

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface MacroDefine : NSObject

@end
