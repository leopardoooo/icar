//
//  SearchTextField.m
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SearchTextField.h"

@interface SearchTextField()<UITextFieldDelegate>

@end

@implementation SearchTextField


-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *) placeholder{
    
    if(self = [super initWithFrame:frame]){
        CGSize iconSize = CGSizeMake(17, 17);
        int padding = 8;
        
        UIView *leftContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconSize.width + padding + padding/2, iconSize.height)];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, 0, iconSize.width , iconSize.height)];
        [iconView setImage:[UIImage imageNamed:@"icon_search_glass"]];
        
        [leftContainerView addSubview:iconView];
        
        self.leftView = leftContainerView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.placeholder = placeholder;
        self.font = [UIFont systemFontOfSize:13];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeySearch;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        
        self.backgroundColor = [UIColor colorWithWhite:0.786 alpha:1.000];
        self.layer.cornerRadius = frame.size.height / 2;
        
        self.delegate = self;
        
        // 添加值改变的事件
        // FIXME: 这里需要排除掉非字符键
        [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    
    SEL sel = @selector(searchTextReturn:target:);
    if ([self.searchDelegate respondsToSelector:sel]) {
        [self.searchDelegate searchTextReturn:[self getKeywordValue] target:self];
    }

    return YES;
}

-(void)valueChanged:(id) field{
    SEL sel = @selector(searchTextBeginSearch:target:);
    if ([self.searchDelegate respondsToSelector:sel]) {
        [self.searchDelegate searchTextBeginSearch:[self getKeywordValue] target:self];
    }

}

-(NSString *) getKeywordValue{
    return self.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
