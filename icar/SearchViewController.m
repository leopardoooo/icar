//
//  SearchViewController.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "NavBackButton.h"
#import "MacroDefine.h"
#import "JLCarouselView.h"
#import "UIView+Border.h"
#import "ViewUtils.h"
#import "SingleRowTableViewCell.h"
#import "SearchTextField.h"
#import "SearchResultTableView.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, SearchTextDelegate, SearchResultDelegate>{
    NSArray * _keywordArray;
    UITableView *_historyTableView;
    NSMutableArray *_historyArray;
    SearchTextField * _searchField;
    SearchResultTableView * _searchResultView;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.931 alpha:1.000];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self createNavView]];
    
    [self createHotKeywordView];
    [self createHistoryView];
    
    [self createResultView];
    
    // 设置成为第一响应者
    [_searchField becomeFirstResponder];
    
    // 加载搜索历史记录
    _historyArray = [[NSMutableArray alloc] init];
    [self initHistoryData];
}

-(void)initHistoryData{
    [_historyArray addObject:@"米其林轮胎"];
    [_historyArray addObject:@"随便看看"];
    
    _historyTableView.hidden = NO;
}

-(void)createResultView{
    
    _searchResultView = [[SearchResultTableView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT)];
    
    _searchResultView.resultDelegate = self;
    
    [self.view addSubview:_searchResultView];
}

-(void)createHistoryView{
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 185, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - 185) style:UITableViewStyleGrouped ];
    
    _historyTableView.backgroundColor = [UIColor clearColor];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    _historyTableView.hidden = YES;
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
    
    _searchField = [[SearchTextField alloc] initWithFrame:CGRectMake(padding, 10, navSize.width - padding * 2.5, 26) withPlaceholder:@"输入宝贝名称、型号、品牌"];
    _searchField.searchDelegate = self;
    
    [navBodyView addSubview:backBtn];
    [navBodyView addSubview:_searchField];
    
    return navBodyView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchField resignFirstResponder];
}

#pragma mark 搜索协议
-(void)searchTextBeginSearch:(NSString *)keyword target:(SearchTextField *)searchField{
    if(keyword.length == 0){
        _searchResultView.hidden = YES;
    }else{
        //FIXME: 通过远程加载数据，这里仅仅是模拟一些数据
        [_searchResultView.dataArray removeAllObjects];
        [_searchResultView.dataArray addObject:@"马牌 轮胎 205/55R16 91V CC5"];
        [_searchResultView.dataArray addObject:@"米其林 国产轮胎 韧悦 195/65R15 91V Energy XM2"];
        [_searchResultView.dataArray addObject:@"固特异 轮胎 配套大师 195/65R15 91V Eagle NCT5"];
        [_searchResultView.dataArray addObject:@"普利司通 轮胎 泰然者 215/60R16 95V ER33UZ"];
        [_searchResultView.dataArray addObject:@"普利司通 轮胎 绿歌伴 205/55R16 91V EP200"];
        [_searchResultView.dataArray addObject:@"普利司通 轮胎 绿歌伴 195/60R15 88H EP150"];
        [_searchResultView.dataArray addObject:@"普利司通 轮胎 泰然者 245/45R18 96V EL400"];
        [_searchResultView.dataArray addObject:@"米其林 轮胎 揽途 225/65R17 102T Latitude Tour 公路"];
        [_searchResultView.dataArray addObject:@"米其林 轮胎 博悦 235/55R17 99H Primacy LC PC"];
        [_searchResultView.dataArray addObject:@"韩泰 轮胎 205/55R16 91V K407"];
        
        [_searchResultView reloadData];
        _searchResultView.hidden = NO;
    }
}

//FIXME: 跳转页面
-(void)searchTextReturn:(NSString *)keyword target:(SearchTextField *)searchField{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtData:(id)indexData{
    NSLog(@"点击了行：%@", indexData);
    _searchField.text = indexData;
    
    
    [_historyArray insertObject:indexData atIndex:0];
    [_historyTableView reloadData];
    _historyTableView.hidden = NO;
    // 跳转页面
    
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
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
    [delBtn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    delBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [delBtn setTitleColor:THEME_COLOR_NORMAL_OBJ forState:UIControlStateNormal];
    [view addSubview:delBtn];
    
    [delBtn addTarget:self action:@selector(deleteHistoryRecords) forControlEvents: UIControlEventTouchUpInside];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"点击了：%ld" , indexPath.row);
}

-(void)deleteHistoryRecords{
    [_historyArray removeAllObjects];
    _historyTableView.hidden = YES;
    // [_historyTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
