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
#define NAV_SIZE self.navigationController.navigationBar.frame.size

@interface HomeViewController (){
    UIView * _maskView;
    SwitchPositionView * _switchPositionView;
    UIView * _barLeftView;
    UIView * _barSearchView;
    UIView * _barToolsView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
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
    _switchPositionView = [[SwitchPositionView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview: _switchPositionView];
    //[[UIApplication sharedApplication].keyWindow addSubview:_switchPositionView];
}

-(void)clickSearchView:(UITapGestureRecognizer *) rec{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark 创建导航视图
-(UIView *) createRightTools{
    int w = 85, y = 5, imgw = 20, imgh = 20 , padding = 15;
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
    if(_switchPositionView.showState == NO){
        [_switchPositionView show];
    }else{
        [_switchPositionView hide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
