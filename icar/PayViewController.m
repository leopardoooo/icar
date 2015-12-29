//
//  PayViewController.m
//  icar
//
//  Created by Killer on 15/11/26.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "PayViewController.h"
#import "UIView+Border.h"
#import "MacroDefine.h"
#import "PayWayTableViewCell.h"
#import "PayWayModel.h"
#import "ViewUtils.h"

@interface PayViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSArray * _dataArray;
    NSIndexPath *_selectedIndexPath;
}

@end

@implementation PayViewController

+(void)open:(UIViewController *)target{
    target.hidesBottomBarWhenPushed = YES;
    PayViewController *vc = [[PayViewController alloc]init];
    vc.title = @"支付订单";
    [target.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _payAmountLabel.font = [UIFont systemFontOfSize:20];
    [_topBarContentView addBottomBorderWithColor:[UIColor colorWithWhite:0.805 alpha:1.000] andWidth:.7];
    // 支付方式列表
    _payWayTableView.delegate = self;
    _payWayTableView.dataSource = self;
    
    
    // 支付渠道
    PayWayModel *pwm = [[PayWayModel alloc ] init];
    pwm.payway = WEIXIN;
    pwm.name = @"微信支付";
    pwm.remark = @"推荐安装微信5.0及以上版本的使用";
    pwm.iconNamed = @"icon_payment_701";
    
    PayWayModel *pwm2 = [[PayWayModel alloc ] init];
    pwm2.payway = ALIPAY;
    pwm2.name = @"支付宝支付";
    pwm2.remark = @"推荐有支付宝账号的使用";
    pwm2.iconNamed = @"icon_payment_201";
    _dataArray = [[NSArray alloc] initWithObjects:pwm, pwm2, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payButtonClick:(id)sender {
    if(!_selectedIndexPath){
        [ViewUtils showAnyIconMessage:JLMessageIconTypeWarn withMessage:@"选择支付方式"];
        return ;
    }
    PayWayModel *payway = _dataArray[_selectedIndexPath.row];
    
    switch (payway.payway) {
        case WEIXIN:
        {
            NSLog(@"微信支付...");
        }
            break;
        case ALIPAY:
        {
            NSLog(@"阿里支付。。");
        }
            break;
        default:
            break;
    }
}

#pragma mark tableView协议接口实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"PayWayTableViewCell";
    PayWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        // 将nib注册到tableView队列中
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    PayWayModel *payway = _dataArray[indexPath.row];
    cell.payImageView.image = [UIImage imageNamed:payway.iconNamed ];
    cell.payTitleLabel.text = payway.name;
    cell.paySubTitleLabel.text = payway.remark;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_selectedIndexPath){
        PayWayTableViewCell *newCell = (PayWayTableViewCell *)[tableView cellForRowAtIndexPath:_selectedIndexPath];
        [newCell setCheckStateView:NO];
    }
    PayWayTableViewCell *newCell = (PayWayTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [newCell setCheckStateView:YES];
    _selectedIndexPath = indexPath;
}

@end
