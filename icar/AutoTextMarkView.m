//
//  AutoTextMarkView.m
//  icar
//
//  Created by Killer on 15/11/13.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "AutoTextMarkView.h"
#import "TemplateUtil.h"
#import "MacroDefine.h"
#import "ViewUtils.h"

#define AutoTextMarkView_HEIGHT 26.0
#define AutoTextMarkView_TEXT_PADDING 14.0


@interface AutoTextMarkView (){
    CGFloat _lastLabelY;
    CGFloat _lastLabelX;
    CGFloat _fontSize;
}
@end

/**
 *  自动的文本标签视图空间， 根据内容自动生成一组按钮
 */
@implementation AutoTextMarkView

- (instancetype)initWithFrame:(CGRect)frame fontSize: (CGFloat) fontSize{
    self = [super initWithFrame:frame hpadding:6.0 vpadding:6.0 startPosx:15];
    if (self) {
        _fontSize = fontSize;
    }
    return self;
}

- (void) addMarkWithArray: (NSArray *) dataArray withTags: (NSArray *) tags bgColor: (UIColor *) borderColor{
    for (int i = 0; i < dataArray.count; i ++) {
        NSNumber *tagNum = tags[i];
        [self addMarkWithString: dataArray[i] withTag:tagNum.integerValue  borderColor:borderColor];
    }
}

- (void) addMarkWithString: (NSString *) mark withTag: (NSUInteger) tag borderColor: (UIColor *) bdColor{
    CGSize size = [ViewUtils sizeWithSingleLine:mark fontSize:_fontSize];
    // 宽度
    size = CGSizeMake(size.width + AutoTextMarkView_TEXT_PADDING, AutoTextMarkView_HEIGHT);
    UIButton *btnView = [TemplateUtil button:mark fontSize:_fontSize color:bdColor frame:CGRectMake(0, 0, size.width, size.height) radius:3 border:1 borderColor:bdColor bgColor:[UIColor whiteColor]];
    // 添加事件
    [btnView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btnView];
}

-(void)btnClick: (UIButton *) sender{
    // 协议不为空，并且实现了协议定义的方法
    if(_delegate && [_delegate respondsToSelector:@selector(markView:didMarkSelected:)]){
        [_delegate markView:self didMarkSelected:sender];
    }
}

@end
