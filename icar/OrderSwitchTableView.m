//
//  OrderSwitchTableView.m
//  icar
//
//  Created by Killer on 15/11/10.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "OrderSwitchTableView.h"
#import "MacroDefine.h"
#import "ViewUtils.h"

@interface OrderSwitchTableView ()<UITableViewDelegate, UITableViewDataSource >{
    NSArray * _dataArray;
    UITableView *_tableView;
    UIButton *_target;
}

@end

@implementation OrderSwitchTableView

-(instancetype)initWithData:(NSArray *)dataArray withTarget: (UIButton *) target{
    if(self = [self initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT)]){
        _dataArray = dataArray;
        _target = target;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self addSubview:_tableView];
        
        //默认选中第一行
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    return self;
}

-(void)show:(float)duration{
    [super show:duration];
    
    [_target setTitleColor:THEME_COLOR_HIGHLIGHTED_OBJ forState:UIControlStateNormal];
}
-(void)hide:(float)duration{
    [super hide:duration];
    [_target setTitleColor:THEME_COLOR_NORMAL_OBJ forState:UIControlStateNormal];
}

#pragma make 表格代理实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"OrderSwitchTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = THEME_COLOR_NORMAL_OBJ;
        cell.textLabel.highlightedTextColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentData = _dataArray[indexPath.row];
    [_target setTitle:_currentData forState:UIControlStateNormal];
    
    [self hide];
}

@end
