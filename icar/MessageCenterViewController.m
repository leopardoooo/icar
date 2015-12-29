//
//  MessageCenterViewController.m
//  icar
//
//  Created by Killer on 15/12/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MacroDefine.h"
#import "Resources.h"
#import "MJRefresh.h"
#import "MyCartDataLoader.h"
#import "MyMessageModel.h"
#import "MultiRowsTableViewCell.h"
#import "ViewUtils.h"

@interface MessageCenterViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSArray * _dataArray;
}

@end

@implementation MessageCenterViewController

+(void)open:(UIViewController *)target{
    target.hidesBottomBarWhenPushed = YES;
    MessageCenterViewController *vc = [[MessageCenterViewController alloc]init];
    vc.title = @"消息中心";
    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    target.navigationItem.backBarButtonItem = returnButtonItem;
    
    [target.navigationController pushViewController:vc animated:YES];
    target.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableData)];
    // 将nib注册到tableView队列中
    [_tableView registerNib:[UINib nibWithNibName:RES_Cell_MultiRowsTableViewCell bundle:nil] forCellReuseIdentifier:RES_Cell_MultiRowsTableViewCell];
    
    // 考试加载
    [_tableView.mj_header beginRefreshing];
}

#pragma mark 数据加载
-(void) loadTableData{
    [MyCartDataLoader queryMyMessage:^(NSMutableArray *data) {
        _dataArray = data;
        [_tableView reloadData];
    } failure:nil done:^{
        [_tableView.mj_header endRefreshing];
    }];
}


#pragma mark tableView协议实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MultiRowsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RES_Cell_MultiRowsTableViewCell];
    MyMessageModel *mm = _dataArray[indexPath.row];
    cell.bigTitleLabel.text = mm.msgTitle;
    cell.subTitleLabel.text = mm.msgDesc;
    cell.dateLabel.text = mm.pubDate;
    cell.readMarkImageView.hidden = mm.readedMark;
    
    return cell;
}

//点击进入详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
