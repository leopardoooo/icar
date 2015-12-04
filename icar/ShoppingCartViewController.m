//
//  ShoppingCartViewController.m
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "MacroDefine.h"
#import "ShoppingCartModel.h"
#import "MyCartDataLoader.h"
#import "UIView+Border.h"
#import "ProductDetailViewController.h"
#import "ProductResultModel.h"
#import "ConfirmOrderViewController.h"
#import "ViewUtils.h"
#import "MJRefresh.h"

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>{
    UIBarButtonItem *_editItem;
    UITableView *_tableView;
    NSArray *_dataArray;
    BOOL _editing;
    BOOL _checkAll;
}

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    _editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didOpenEditMode)];
    [_editItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = _editItem;
    
    // 结算工具条增加边框颜色
    [_payToolBarView addTopBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.7];
    _totalLabel.font = [UIFont systemFontOfSize: 17];
    [_selectedAllLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedAllBoxClick:)]];
    
    // 初始化状态标记
    _editing = NO;
    _checkAll = NO;
    
    // tableView 创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - 113 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = THEME_COLOR_BORDER_OBJ;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMyCartData)];
    [self.view addSubview:_tableView];
    
    // 开始加载数据
    [_tableView.mj_header beginRefreshing];
}

#pragma mark  加载数据
-(void)loadMyCartData{
    // 加载数据
    [MyCartDataLoader queryMyCartWithHandler:^(NSMutableArray *data) {
        _editing = NO;
        _checkAll = NO;
        
        [_tableView.mj_header endRefreshing];
        _dataArray = data;
        [_tableView reloadData];
    }];
}

#pragma mark 事件处理实现
// 编辑时间
-(void)didOpenEditMode{
    _editing = !_editing;
    _editItem.title = _editing ? @"完成" : @"编辑";
    // 重载数据
    [_tableView reloadData];
    // Bar的子视图重新显示
    _joinCollectBtn.hidden = !_editing;
    _deleteCheckedBtn.hidden = !_editing;
    _settleBtn.hidden = _editing;
    _totalLabel.hidden = _editing;
    _labelForTotalView.hidden = _editing;
    
    // 完成时计算金额
    if(!_editing){
        [self doResetTotalFee];
    }
}
// 全选按钮
- (IBAction)didSelectedAllBoxClick:(id)sender {
    _checkAll = !_checkAll;
    [_selectedAllBox setImage:[UIImage imageNamed:_checkAll ? @"icon_radio_on" : @"icon_radio"] forState:UIControlStateNormal];
    
    [_dataArray enumerateObjectsUsingBlock:^(ShoppingCartModel *scm, NSUInteger idx, BOOL *stop) {
        scm.checked = _checkAll;
    }];
    [_tableView reloadData];
    [self doResetTotalFee];
}
// 结算按钮事件：结算选中的
- (IBAction)didSettleBtnClick:(id)sender {
    NSArray *prods = [self getAnyProductsWithChecked:YES];
    if(prods.count > 0 ){
        [ConfirmOrderViewController open:self withData: prods];
    }else{
        [ViewUtils showMessage:@"请先选择商品!"];
    }
}
// 删除选中的商品
- (IBAction)didDeleteBtnClick:(id)sender {
    if([self getAnyProductsWithChecked:YES].count == 0){
        return ;
    }
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除选中商品" otherButtonTitles:nil];
    [actions showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [self removeSelectedProducts];
        }
            break;
        default:
            break;
    }
}

#pragma mark 内部重要方法
// 计算价格和结算商品数
-(void)doResetTotalFee{
    // 总金额
    float total = 0;
    // 数量
    int count = 0;
    for (int i = 0 ; i < _dataArray.count; i++) {
        ShoppingCartModel *scm = _dataArray[i];
        if(scm.checked){
            count ++;
            total += scm.buyPrice * scm.buyCount;
        }
    }
    _totalLabel.text = [NSString stringWithFormat:@"%.2f", total];
    [_settleBtn setTitle:[NSString stringWithFormat:@"结算(%d)", count] forState:UIControlStateNormal];
}
// 删除选中的商品
-(void)removeSelectedProducts{
    NSArray *keepProds = [self getAnyProductsWithChecked: NO];
    if(keepProds.count < _dataArray.count){
        _dataArray = keepProds;
        [_tableView reloadData];
    }
}
// 获得选中或者非选中状态的商品
-(NSArray *) getAnyProductsWithChecked: (BOOL) checked{
    NSMutableArray *anyArray = [[NSMutableArray alloc] init];
    [_dataArray enumerateObjectsUsingBlock:^(ShoppingCartModel *scm, NSUInteger idx, BOOL *stop) {
        if(scm.checked == checked){
            [anyArray addObject:scm];
        }
    }];
    return anyArray;
}

#pragma mark tableView协议实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    
    return view ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        // 将nib注册到tableView队列中
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        // 从队列中重新获取Cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    cell.parent = self;
    // 设置参数
    [cell loadCellDataWithShoppingCartModel:_dataArray[indexPath.row]];
    // 编辑模式
    if(_editing){
        cell.editInfoContentView.hidden = NO;
        cell.prodInfoContentView.hidden = YES;
    }else{
        cell.editInfoContentView.hidden = YES;
        cell.prodInfoContentView.hidden = NO;
    }
    
    return cell;
}

//点击进入详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartModel *scm = _dataArray[indexPath.row];
    ProductResultModel *prm = [[ProductResultModel alloc] init];
    prm.prodName = scm.prodName;
    prm.prodPrice = scm.buyPrice;
    prm.prodImageUrl = scm.prodCartImage;
    
    [ProductDetailViewController openProductDetailViewController:self withProduct:prm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
