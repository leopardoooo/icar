//
//  SimpleWebView.h
//  icar
//
//  Created by Killer on 15/11/18.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleWebView : UIWebView

-(void)loadRequestWithString:(NSString *)requestUrl;

@end
