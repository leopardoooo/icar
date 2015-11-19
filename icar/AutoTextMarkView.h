//
//  AutoTextMarkView.h
//  icar
//
//  Created by Killer on 15/11/13.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowLayoutView.h"


@class AutoTextMarkView;

// 定义一个协议
@protocol AutoTextMarkViewDelegate <NSObject>

@required
// 标签被点击将会被触发
-(void)markView: (AutoTextMarkView *) view didMarkSelected: (UIButton *) target;
@end

@interface AutoTextMarkView : FlowLayoutView

@property (nonatomic, strong) id<AutoTextMarkViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame fontSize: (CGFloat) fontSize;

- (void) addMarkWithArray: (NSArray *) dataArray withTags: (NSArray *) tags bgColor: (UIColor *) borderColor;

- (void) addMarkWithString: (NSString *) mark withTag: (NSUInteger) tag borderColor: (UIColor *) bdColor;


@end
