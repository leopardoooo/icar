//
//  SearchResultTableView.m
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SearchResultTableView.h"
#import "SingleRowTableViewCell.h"
#import "MixedUtils.h"

@interface SearchResultTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation SearchResultTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [self initWithFrame:frame style:UITableViewStyleGrouped]){
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 默认隐藏起来
        self.hidden = YES;
        self.dataSource = self;
        self.delegate = self;
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"SingleRowTableViewCell";
    SingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        cell.iconImageView.image = [UIImage imageNamed:@"icon_search_empty"];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.text = _dataArray[indexPath.row];
    cell.subTitleLabel.text = [NSString stringWithFormat:@"共%d个结果", [MixedUtils getRandomNumber:1 to:100]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id value = _dataArray[indexPath.row];
    SEL sel = @selector(tableView:didSelectRowAtData:);
    if ([self.resultDelegate respondsToSelector:sel]) {
        [self.resultDelegate tableView:tableView didSelectRowAtData:value];
    }
}

@end
