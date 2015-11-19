//
//  ImageBrowserViewController.h
//  icar
//
//  Created by Killer on 15/11/16.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrowserViewController : UIViewController

@property(nonatomic, strong) NSArray *imgurlArray;
@property(nonatomic, assign) NSUInteger currentIndex;
@property(nonatomic, assign) NSUInteger total;

/**
 *  静态方法打开一个图片浏览器
 */
+(void)openImageBrowser:(UIViewController *)target withUrls: (NSArray *) urlArray backHideBottom: (BOOL) hide;

@end
