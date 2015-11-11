//
//  SearchTextField.h
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SearchTextField;

@protocol SearchTextDelegate <NSObject>

// 必须实现的协议
@required
/**
 *  搜索方法，需要去实现的协议
 *
 *  @param keyword     关键字
 *  @param searchField 当前搜索Field引用
 */
-(void)searchTextBeginSearch:(NSString *) keyword target: (SearchTextField *) searchField;

/**
 *  点击done时会调用该协议
 */
-(void)searchTextReturn:(NSString *) keyword target:(SearchTextField *) searchField;

@optional

@end

@interface SearchTextField : UITextField

@property (nonatomic, strong) id<SearchTextDelegate> searchDelegate;

-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *) placeholder;

-(NSString *) getKeywordValue;

@end
