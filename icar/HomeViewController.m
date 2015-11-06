//
//  HomeViewController.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "MacroDefine.h"
#import "SwitchPositionView.h"
#import "SearchViewController.h"
#import "JLCarouselView.h"
#import "AppNavigationController.h"

// 宏定义
#define NAV_SIZE self.navigationController.navigationBar.frame.size

@interface HomeViewController (){
    UIView * _maskView;
    SwitchPositionView * _switchPositionView;
    UIView * _barLeftView;
    UIView * _barSearchView;
    UIView * _barToolsView;
}

@end


/**
 *  首页控制器，这是整个页面布局的组装控制器，可能不包含具体UI的实现
 */
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self initAndAddCarouselView];
    
    // 重写导航条
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, NAV_SIZE.width, NAV_SIZE.height - 12)];
    _barLeftView = [self createLeftView];
    _barToolsView = [self createRightTools];
    _barSearchView = [self createSearchView];
    [navView addSubview:_barLeftView];
    [navView addSubview:_barSearchView];
    [navView addSubview:_barToolsView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: navView];
    
    // 为搜索视图添加手势
    UITapGestureRecognizer *tabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchView:)];
    [_barSearchView addGestureRecognizer:tabRecognizer];
    
    // 创建地理位置选择视图
    _switchPositionView = [[SwitchPositionView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SCREEN_HEIGHT) withParent:self];
    [self.view addSubview: _switchPositionView];
    //[[UIApplication sharedApplication].keyWindow addSubview:_switchPositionView];
}

-(void)initAndAddCarouselView{
    self.carouselView = [[JLCarouselView alloc]initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, 160) withPages:5];
    self.carouselView.pageControl.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.1];
    // 添加广告页
//FIXME: 需要修改成异步加载，不然影响效率，推荐SDImageXXX第三方
    NSArray *ads = @[@"http://img.tqmall.com/config/2015/07/10/143649893449_web.jpg",@"http://img.tqmall.com/config/2015/07/20/143737134574_web.jpg",@"http://img.tqmall.com/config/2015/09/29/144351121430_web.jpg",@"http://img.tqmall.com/config/2015/10/22/144547593086_web.jpg",@"http://img.tqmall.com/config/2015/08/11/143925567550_web.jpg"];

    for (int i = 0 ; i < ads.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.carouselView.frame.size.width * i, 0, self.carouselView.frame.size.width, self.carouselView.frame.size.height)];        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ads[i]]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        [imageView setImage:image];
        [self.carouselView addToScrollView:imageView];
    }
    
    [self.view addSubview:self.carouselView];
}

-(void)clickSearchView:(UITapGestureRecognizer *) rec{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark 创建导航视图
-(UIView *) createRightTools{
    int w = 85, y = 7, imgw = 20, imgh = 20 , padding = 15;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(NAV_SIZE.width - w, y, w, imgh)];
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(0, 0, imgw, imgh);
    [scanBtn setImage:[UIImage imageNamed:@"icon_homepage_scan"] forState:UIControlStateNormal];
    
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(padding + imgw, 0, imgw, imgh);
    [msgBtn setImage:[UIImage imageNamed:@"icon_homepage_message"]
        forState:UIControlStateNormal];
    
    [view addSubview:scanBtn];
    [view addSubview:msgBtn];
    return view;
}
#pragma mark 创建搜索视图
-(UIView *) createSearchView{
    int w = 210, padding = (NAV_SIZE.width - _barLeftView.frame.size.width - _barToolsView.frame.size.width - w)/2;
    int h = 26;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(_barLeftView.frame.size.width + padding, 3, w , h)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 13;
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 7, 13, 13)];
    [searchImageView setImage:[UIImage imageNamed:@"icon_homepage_search"]];
    [view addSubview:searchImageView];
    
    UILabel *keywordLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, view.frame.size.width - 26, view.frame.size.height)];
    keywordLabel.text = @"输入宝贝名称、型号、品牌";
    keywordLabel.textColor = [UIColor colorWithRed:0.161 green:0.771 blue:0.707 alpha:1.000];
    keywordLabel.font = [UIFont systemFontOfSize:13];
    
    [view addSubview:keywordLabel];
    
    return view;
}

#pragma make 创建选择地理位置的视图
-(UIView *) createLeftView{
    int h = 30, w = 39, iw = 10, ih = 8;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 2, w, h)];
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleInPostion:)];
    
    [view addGestureRecognizer: tapGesture];
    view.userInteractionEnabled = YES;
    
    self.posLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w - iw, h)];
    _posLabel.text = @"杭州";
    _posLabel.textColor = [UIColor whiteColor];
    _posLabel.font = [UIFont systemFontOfSize:13];
    
    self.posImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_posLabel.frame.size.width, (h - ih) / 2, iw, ih)];
    [_posImageView setImage:[[UIImage imageNamed:@"icon_homepage_downArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] ];
    [_posImageView setHighlightedImage:[UIImage imageNamed:@"icon_homepage_upArrow"]];
    
    [view addSubview:_posLabel];
    [view addSubview:_posImageView];
    
    return view;
}

-(void) toggleInPostion: (UITapGestureRecognizer *)recognizer{
    [_switchPositionView toggle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    
    // 5秒轮播一次
    [self.carouselView startTimer:5];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppNavigationController *nav = (AppNavigationController *)self.navigationController;
    [nav resetAppBarStyle];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [_switchPositionView hide];
    
    // 停止轮播
    [self.carouselView stopTimer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
