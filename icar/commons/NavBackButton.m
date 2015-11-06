//
//  NavBackButton.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "NavBackButton.h"

/*
 扩展系统返回按钮，主要定义了系统需要的返回按钮颜色以及事件
 */
@implementation NavBackButton

+(id)buttonWithNavigation: (UINavigationController *) navc withFrame: (CGRect)frame{
    NavBackButton *btn = [NavBackButton buttonWithType:UIButtonTypeCustom];
    btn.navc = navc;
    [btn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    btn.frame = frame;
    [btn addTarget:btn action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)back{
    [self.navc popViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
