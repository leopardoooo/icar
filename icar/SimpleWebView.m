//
//  SimpleWebView.m
//  icar
//
//  Created by Killer on 15/11/18.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SimpleWebView.h"

@interface SimpleWebView () <UIWebViewDelegate>{
    
}

@end

@implementation SimpleWebView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.delegate = self;
        
    }
    return self;
}

-(void)loadRequestWithString:(NSString *)requestUrl{
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest: request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight =[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
