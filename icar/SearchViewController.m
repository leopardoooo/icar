//
//  SearchViewController.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTextView.h"
#import "NavBackButton.h"
#import "MacroDefine.h"
#import "JLCarouselView.h"
#import "UIView+Border.h"
#import "ViewUtils.h"
#import "SingleRowTableViewCell.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>{
    SearchTextView * _searchView;
    NSArray * _keywordArray;
    UITableView *_historyTableView;
    NSMutableArray *_historyArray;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.931 alpha:1.000];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self createNavView]];
    
    _historyArray = [[NSMutableArray alloc] initWithObjects:@"米其林轮胎",@"随便看看", nil];
    
    [self createHotKeywordView];
    [self createHistoryView];
    
    // 设置成为第一响应者
    [_searchView.keywordField becomeFirstResponder];
}

-(void)createHistoryView{
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 185, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - 185) style:UITableViewStyleGrouped ];
    
    _historyTableView.backgroundColor = [UIColor clearColor];
    
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    [self.view addSubview: _historyTableView];
}

-(void) createHotKeywordView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, 170)];
    view.backgroundColor = [UIColor colorWithWhite:0.942 alpha:1.000];
    [view addBottomBorderWithColor:[UIColor colorWithWhite:0.872 alpha:1.000]  andWidth:.7];
    
    
    UILabel *hotTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, SELF_SIZE_WIDTH, 40)];
    hotTitle.text = @"热门搜索";
    hotTitle.textColor = THEME_DFAULT_TITLE_COLOR_OBJ;
    hotTitle.font = [UIFont systemFontOfSize:13];
    
    // 根据数据动态创建可点击的按钮
    _keywordArray = @[@"黄壳",@"火花塞",@"滤清器",@"蓄电池",@"红壳",@"蓝壳",@"金嘉护",@"刹车片",@"柴机油",@"Test",@"AAAA"];
    long limit = 9, pages = _keywordArray.count / limit + (_keywordArray.count % limit != 0 ? 1 : 0);
    JLCarouselView *keywordView = [[JLCarouselView alloc] initWithFrame:CGRectMake(15, 40, SELF_SIZE_WIDTH - 30, 136) withPages:pages];
    
    long cols = 3, padding = 5, btnWidth = keywordView.frame.size.width / cols - padding, btnHeight = 32;
    for(long p = 0; p < pages; p++){
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(p * keywordView.frame.size.width, 0, keywordView.frame.size.width, 100)];
        for (long start = p * limit, i = start; i < start + limit && i < _keywordArray.count; i++) {
            long currentCol = (i - start) % cols, currentRow = (i - start)/ cols;
            long posX = (currentCol == 0) ? 0 : btnWidth * currentCol + padding * currentCol;
            long posY = (currentRow == 0) ? 0 : btnHeight * currentRow + padding * currentRow;
            UIButton *btn = [ViewUtils buttonWithTitle:_keywordArray[i] withFrame:CGRectMake(posX, posY, btnWidth, btnHeight)];
            //[btn addTarget:self action:@selector(togglePosition:) forControlEvents:UIControlEventTouchUpInside];
            [pageView addSubview:btn];
        }
        [keywordView addToScrollView:pageView];
    }

    [view addSubview:hotTitle];
    [view addSubview:keywordView];
    [self.view addSubview:view];
}

-(UIView *) createNavView{
    CGSize navSize = self.navigationController.navigationBar.frame.size;
    UIView *navBodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, navSize.width, navSize.height)];
    
    NavBackButton *backBtn = [NavBackButton buttonWithNavigation:self.navigationController withFrame:CGRectMake(-5, 12, 22, 22)];
    int padding = 30;
    _searchView = [[SearchTextView alloc] initWithFrame:CGRectMake(padding, 10, navSize.width - padding * 2.5, 26)];
    
    [navBodyView addSubview:backBtn];
    [navBodyView addSubview:_searchView];
    
    return navBodyView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchView.keywordField resignFirstResponder];
}

#pragma mark TableView协议实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _historyArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"SingleRowTableViewCell";
    SingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        cell.iconImageView.image = [UIImage imageNamed:@"icon_search_history"];
        cell.subTitleLabel.text = @"";
    }
    cell.titleLabel.text = _historyArray[indexPath.row];
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight)];
    view.backgroundColor = [UIColor whiteColor];
    
    int left = (tableView.frame.size.width - 110)/2;
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(left, 12, 16, 16)];
    iconImage.image = [UIImage imageNamed:@"icon_search_history"];
    
    [view addSubview:iconImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + iconImage.frame.size.width + 5, 0, 80, 40)];
    titleLabel.text = @"清除历史记录";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = THEME_COLOR_NORMAL_OBJ;
    [view addSubview:titleLabel];
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"点击了：%ld" , indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
