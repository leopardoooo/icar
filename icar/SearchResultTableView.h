//
//  SearchResultTableView.h
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultDelegate <NSObject>

@required
-(void)tableView:(UITableView *)tableView didSelectRowAtData:(id)indexData;

@end

@interface SearchResultTableView : UITableView

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) id<SearchResultDelegate> resultDelegate;

@end
