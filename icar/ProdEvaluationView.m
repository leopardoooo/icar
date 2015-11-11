//
//  ProdEvaluationView.m
//  icar
//
//  Created by Killer on 15/11/11.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProdEvaluationView.h"
#import "MacroDefine.h"
#import "MixedUtils.h"

@interface ProdEvaluationView (){
    
}

@end

@implementation ProdEvaluationView

-(instancetype)initWithPosy:(CGFloat) posy{
    if(self = [super initWithFrame:CGRectMake(0, posy, SCREEN_WIDTH, 300)]){
        
        self.backgroundColor = [UIColor whiteColor];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 40)];
        label.text = [NSString stringWithFormat:@"商品评价（%d）",  [MixedUtils getRandomNumber:1 to:9999]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = THEME_COLOR_NORMAL_OBJ;
        
        [self addSubview:label];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
