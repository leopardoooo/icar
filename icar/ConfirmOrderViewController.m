//
//  ConfirmOrderViewController.m
//  icar
//
//  Created by Killer on 15/11/24.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "UIView+Border.h"
#import "MacroDefine.h"
#import "ConfirmOrderTableViewCell.h"
#import "PayViewController.h"

#define ConfirmOrderViewController_ROW_PADDING 10

@interface ConfirmOrderViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSArray * _buyOptionsArray;
}

@end

@implementation ConfirmOrderViewController

+(void)open:(UIViewController *)target withData: (NSArray *) dataArray{
    target.hidesBottomBarWhenPushed = YES;
    ConfirmOrderViewController *vc = [[ConfirmOrderViewController alloc]initWithData: dataArray];
    vc.title = @"确认订单";
    [target.navigationController pushViewController:vc animated:YES];
    target.hidesBottomBarWhenPushed = NO;
}

-(instancetype)initWithData:(NSArray *)dataArray{
    if(self = [super init] ){
        _dataArray = dataArray;
        [_dataArray enumerateObjectsUsingBlock:^(ShoppingCartModel *o, NSUInteger idx, BOOL *stop) {
            o.serviceItems = @[@[@"售后服务",@"质保一年100.00元", @"link"],
                               @[@"配送方式",@"上门维修", @"link"],
                               @[@"发票抬头", @"李大嘴", @"input"]
                               ];
        }];
        _buyOptionsArray = @[@"可用872积分抵扣￥8.72",@"匿名购买"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 样式设置
    _totalFeeLabel.text = @"1000.00";
    [_bottomBarContentView addTopBorderWithColor:[UIColor colorWithWhite:0.777 alpha:1.000] andWidth:.7];
    
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SELF_SIZE_HEIGHT - _bottomBarContentView.frame.size.height + 3) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = THEME_COLOR_BORDER_OBJ;
    [self.view addSubview:_tableView];
    
    // 总费用
    _totalFeeLabel.text = [NSString stringWithFormat:@"%.2f", [self doCalcTotalFee]];
    
}

#pragma mark 按钮点击事件
// 确认按钮事件
- (IBAction)didConfirmBtnClick:(id)sender {
    [PayViewController open:self];
}
// 计算总金额
- (float)doCalcTotalFee{
    float total = 0;
    for (int i = 0 ; i < _dataArray.count; i++) {
        ShoppingCartModel *scm = _dataArray[i];
        total += scm.buyPrice * scm.buyCount;
    }
    return total;
}


#pragma mark tableView协议接口实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartModel *scm = _dataArray[indexPath.section];
    return 100 + scm.serviceItems.count * ConfirmOrderTableViewCell_ROW_HEIGHT + 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section != _dataArray.count - 1){
        return 0.001;
    }
    return [self getFooterViewHeight];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section != _dataArray.count - 1){
        return nil;
    }
    UIView *targetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self getFooterViewHeight])];
    [targetView addBottomBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.7];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ConfirmOrderViewController_ROW_PADDING, tableView.frame.size.width, ConfirmOrderTableViewCell_ROW_HEIGHT * _buyOptionsArray.count)];
    contentView.backgroundColor = THEME_WHITE_COLOR;
    // 添加Item
    for (int i = 0 ; i < _buyOptionsArray.count; i++) {
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(15, ConfirmOrderTableViewCell_ROW_HEIGHT * i, contentView.frame.size.width - 30, ConfirmOrderTableViewCell_ROW_HEIGHT)];
        
        if(i != _buyOptionsArray.count - 1){
            [itemView addBottomBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.7];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, ConfirmOrderTableViewCell_ROW_HEIGHT)];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = _buyOptionsArray[i];
        [itemView addSubview:titleLabel];
        
        UISwitch *switchToggle = [[UISwitch alloc] initWithFrame:CGRectMake(itemView.frame.size.width - 50, 5, 0, 0)];
        switchToggle.on = YES;
        [itemView addSubview:switchToggle];
        
        [contentView addSubview:itemView];
    }
    
    [targetView addSubview:contentView];
    return targetView;
}
-(float) getFooterViewHeight{
    return ConfirmOrderTableViewCell_ROW_HEIGHT * _buyOptionsArray.count + ConfirmOrderViewController_ROW_PADDING + .7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ConfirmOrderTableViewCell";
    ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        // 将nib注册到tableView队列中
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    // 加载数据
    [cell loadCellWithData:_dataArray[indexPath.section]];
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
