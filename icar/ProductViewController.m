//
//  ProductViewController.m
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductViewController.h"
#import "MacroDefine.h"
#import "UIView+Border.h"
#import "ProductTableViewCell.h"
#import "ProductResultModel.h"
#import "ProductTableView.h"
#import "OrderSwitchTableView.h"
#import "SplitCategoryView.h"
#import "SearchViewController.h"
#import "ProductDetailViewController.h"
#import "ProductDataLoader.h"
#import "TemplateUtil.h"


@interface ProductViewController() <UIScrollViewDelegate>{
    UIScrollView * _scrollView;
    NSMutableArray * _tabLabelViews;
    UILabel *_highlightLabelView;
    ProductTableView * _allTableView;
    ProductTableView * _myTempTableView;
    
    // 过滤，排序相关的组件声明
    OrderSwitchTableView * _orderSwitchView;
    SplitCategoryView * _splitCategoryView;
    UIButton *_filterBtn;
    UIButton *_saleOrderBtn;
    UIButton *_complexOrderBtn;
    
    // top
    UIButton *_backTopBtn;
}
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 当前视图启动设置
    self.view.backgroundColor = [UIColor whiteColor];
    _tabLabelViews = [[NSMutableArray alloc] init];
    
    // 初始化导航视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: [self createNavView]];
    
    // 搜索过滤
    [self createFilterBar];
    
    // 滚动内容初始化
    [self createScrollView];
    
    //默认激活第1个
    [self activeTab: 0 scroll:NO];
    
    // 添加浮层
    [self createFilterOrderModelView];
    
    // 加载数据
    [_allTableView firstLoadTableData];
    
    // 返回到顶部按钮
    _backTopBtn = [TemplateUtil buttonWithImage:[UIImage imageNamed:@"back_top"] frame:CGRectMake(SELF_SIZE_WIDTH - 60, SELF_SIZE_HEIGHT - 195, 36, 36)];
    [self.view addSubview:_backTopBtn];
}

//
-(void)createFilterBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, 36)];
    [view addBottomBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.5];
    int bw = SELF_SIZE_WIDTH / 3, bh = view.frame.size.height;
    
    // 全部分类
    _filterBtn = [self createDefaultFilterButton:@"全部分类" withFrame:CGRectMake(0, 0, bw, bh) withTag:100];
    [view addSubview: _filterBtn];
    // 销量优先
    _saleOrderBtn = [self createDefaultFilterButton:@"销量优先" withFrame:CGRectMake(bw, 0, bw, bh) withTag:101];
    [view addSubview: _saleOrderBtn];
    // 综合排序
    _complexOrderBtn = [self createDefaultFilterButton:@"综合排序" withFrame:CGRectMake(bw*2, 0, bw, bh) withTag:102];
    [view addSubview: _complexOrderBtn];
    
    [self.view addSubview:view];
}

-(void)createFilterOrderModelView{
    // 排序
    _orderSwitchView = [[OrderSwitchTableView alloc] initWithData:@[@"综合排序",@"价格从高到低",@"价格从低到高",@"好评优先"] withTarget: _complexOrderBtn];
    [self.view addSubview:_orderSwitchView];
    
    // 筛选
    _splitCategoryView = [[SplitCategoryView alloc] initWithTarget:_filterBtn];
    [self.view addSubview:_splitCategoryView];
}

-(UIButton *) createDefaultFilterButton: (NSString *)title withFrame: (CGRect) frame withTag: (int) tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor colorWithWhite:0.237 alpha:1.000] forState:UIControlStateNormal];
    [btn setTitleColor:THEME_COLOR_HIGHLIGHTED_OBJ forState:UIControlStateHighlighted];
    btn.frame = frame;
    btn.tag = tag;
    
    [btn addRightBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:1.0];
    
    [btn addTarget:self action:@selector(filterOrderClick:) forControlEvents:UIControlEventTouchUpInside];
   
    return btn;
}

//初始化导航视图
-(UIView *)createNavView{
    CGSize size = self.navigationController.navigationBar.frame.size;
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    NSArray *tabs = @[@"全部配件",@"我的车型"];
    int w = 60, padding = 10;
    for (int i = 0;i < tabs.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i* (w+padding), 5, w, size.height - 10 );
        [btn setTitle:tabs[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(toggleTabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [nav addSubview: btn];
        [_tabLabelViews addObject:btn];
    }
    
    // 高亮边框
    _highlightLabelView = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, w, 3)];
    _highlightLabelView.backgroundColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    [nav addSubview:_highlightLabelView];
    
    // 搜索图标
    UIButton *sicon = [UIButton buttonWithType:UIButtonTypeCustom];
    sicon.frame = CGRectMake(size.width - 50, 14, 20, 20);
    [sicon setImage:[UIImage imageNamed:@"icon_search_glass"] forState:UIControlStateNormal];
    [sicon addTarget:self action:@selector(openSearchVC) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:sicon];
    
    return nav;
}

//scrollView
-(void)createScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - 140)];
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(SELF_SIZE_WIDTH * _tabLabelViews.count, 0);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    [self.view addSubview:_scrollView];
    
    // 表格初始化
    _allTableView = [[ProductTableView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, _scrollView.frame.size.height) parent:self ];
    _myTempTableView = [[ProductTableView alloc] initWithFrame:CGRectMake(SELF_SIZE_WIDTH, 0, SELF_SIZE_WIDTH, _scrollView.frame.size.height) parent:self];
    [_scrollView addSubview:_allTableView];
    [_scrollView addSubview:_myTempTableView];
}

#pragma mark 按钮事件处理方法
//打开搜索页
-(void)openSearchVC{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

// 点击导航栏tab页处理事件
-(void)toggleTabClick: (UIButton *) btn{
    for (int i = 0; i < _tabLabelViews.count; i++) {
        UIButton *btnTmp = _tabLabelViews[i];
        if(btnTmp == btn){
            [self activeTab:i scroll:YES];
            break;
        }
    }
}
// 点击过滤或排序按钮事件处理
-(void)filterOrderClick: (UIButton *) btn{
    switch (btn.tag) {
        case 102:
        {
            [_orderSwitchView toggle];
            [_splitCategoryView hide];
        }
            break;
        case 100:
        {
            [_orderSwitchView hide];
            [_splitCategoryView toggle];
        }
            break;
        default:
            // 销量优先
            [_orderSwitchView hide];
            [_splitCategoryView hide];
            break;
    }
}

#pragma mark 相关协议接口实现
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self activeTab:page scroll:NO];
}

#pragma mark 本地私有方法实现
// 激活指定的tab页
-(void)activeTab: (NSUInteger) index scroll: (BOOL)requireScoll{
    for (int i = 0; i < _tabLabelViews.count; i++) {
        UIButton *btn = _tabLabelViews[i];
        if(i == index){
            [btn setTitleColor:THEME_COLOR_HIGHLIGHTED_OBJ forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }
    CGRect hllFrame = _highlightLabelView.frame;
    // x = index * (width + padding)
    _highlightLabelView.frame = CGRectMake(index * (hllFrame.size.width+10), hllFrame.origin.y, hllFrame.size.width, hllFrame.size.height);
    
    if(requireScoll){
        CGSize size = _scrollView.frame.size;
        [_scrollView scrollRectToVisible:CGRectMake(index * size.width, 0, size.width, size.height) animated:YES];
    }
}

@end
