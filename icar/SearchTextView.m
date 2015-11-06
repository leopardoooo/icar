//
//  SearchTextView.m
//  icar
//
//  Created by Killer on 15/11/6.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SearchTextView.h"


/*
 //该类主要实现了搜索框以及图标
 FIXME: 修改成扩展TextField的实现方式
 */
@implementation SearchTextView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithWhite:0.786 alpha:1.000];
        self.layer.cornerRadius = frame.size.height / 2;
        
        
        [self createIconAndTextView];
        
    }
    return self;
}

-(void)createIconAndTextView{
    int mh = 17, mw = 17, x = 6;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(6, (self.frame.size.height - mh)/ 2, mw, mh)];
    [iconView setImage:[UIImage imageNamed:@"icon_search_glass"]];
    
    int textFieldX = x + mw + 5;
    _keywordField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, 0, self.frame.size.width - textFieldX, self.frame.size.height)];
    _keywordField.placeholder = @"输入宝贝名称、品牌、型号";
    _keywordField.font = [UIFont systemFontOfSize:13];
    
//    _keywordField.clearsOnBeginEditing = NO;
    _keywordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _keywordField.returnKeyType = UIReturnKeyDefault;
    _keywordField.keyboardAppearance = UIKeyboardAppearanceDefault;

    
    [self addSubview:iconView];
    [self addSubview:_keywordField];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
