//
//  ProductBuyBarView.m
//  icar
//
//  Created by Killer on 15/11/18.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductBuyBarView.h"
#import "ProductResultModel.h"
#import "MacroDefine.h"
#import "UIView+Border.h"
#import "TemplateUtil.h"

@interface ProductBuyBarView () {
    ProductResultModel * _product;
}

@end

@implementation ProductBuyBarView

-(instancetype)initWithParent: (UIViewController *) vc withProduct: (ProductResultModel *) prm{
 
    CGFloat height = 45.0, poxy = SCREEN_HEIGHT - APP_STATUSBAR_SIZE.height - vc.navigationController.navigationBar.frame.size.height - height;
    if(self = [super initWithFrame:CGRectMake(0, poxy, vc.view.frame.size.width, height)]){
        _product = prm;
        [self addTopBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.7];
        self.backgroundColor = [UIColor whiteColor];
        [self createViews];
    }
    return self;
}

-(void)createViews{
    CGFloat width = self.frame.size.width, btnw = 120;
    // 立即购买按钮
    UIButton * buyBtn = [TemplateUtil button:@"立即购买" fontSize:15 color: THEME_WHITE_COLOR frame:CGRectMake(width - btnw, 0, btnw, self.frame.size.height) radius:0 border:0 borderColor:nil bgColor:[UIColor colorWithRed:0.933 green:0.306 blue:0.052 alpha:1.000]];
    
    // 加入购物车按钮
    UIButton * toCartBtn = [TemplateUtil button:@"加入购物车" fontSize:15 color: THEME_WHITE_COLOR frame:CGRectMake(width - btnw * 2, 0, btnw, self.frame.size.height) radius:0 border:0 borderColor:nil bgColor:THEME_COLOR_HIGHLIGHTED_ORAGE_OBJ];
    
    [self addSubview:toCartBtn];
    [self addSubview:buyBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
