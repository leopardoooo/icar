//
//  ProdSpecTableView.m
//  icar
//
//  Created by Killer on 15/11/11.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProdSpecTableView.h"
#import "MacroDefine.h"
#import "ChooseProductView.h"

@interface ProdSpecTableView ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray * _dataArray;
}

@end

@implementation ProdSpecTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame style:UITableViewStyleGrouped]){
        _dataArray = @[@"产品参数", @"请选择颜色分类"];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.scrollEnabled = NO;
        self.separatorColor = THEME_COLOR_BORDER_OBJ;
        
    }
    return self;
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ProdSpecTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = THEME_COLOR_NORMAL_OBJ;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self openChooseProductWindow];
}

-(void)openChooseProductWindow{
    [ChooseProductView showChooseProductWindow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
