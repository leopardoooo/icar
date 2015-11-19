//
//  ImageBrowserViewController.m
//  icar
//
//  Created by Killer on 15/11/16.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "AppNavigationController.h"
#import "MacroDefine.h"

@interface ImageBrowserViewController () <UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UIImageView *_leftImageView;
    UIImageView *_mainImageView;
    UIImageView *_rightImageView;
}

@end

@implementation ImageBrowserViewController


+(void)openImageBrowser:(UIViewController *)target withUrls: (NSArray *) urlArray backHideBottom: (BOOL) hide{
    target.hidesBottomBarWhenPushed = YES;
    ImageBrowserViewController *vc = [[ImageBrowserViewController alloc]init];
    vc.imgurlArray = urlArray;
    vc.total = urlArray.count;
    vc.currentIndex = 0;
    
    [target.navigationController pushViewController:vc animated:YES];
    target.hidesBottomBarWhenPushed = hide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self prepareSubview];
    
    // 第0张图片开始
    [self reloadImageView:0];
}

-(void)prepareSubview{
    // 添加scroll视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - SELF_NAVBAR.frame.size.height - APP_STATUSBAR_SIZE.height)];
    _scrollView.backgroundColor = [UIColor blackColor];
    //_scrollView.showsHorizontalScrollIndicator = NO;
    CGSize size = _scrollView.frame.size;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    
    if(_total > 1){
        _scrollView.contentSize = CGSizeMake(SELF_SIZE_WIDTH * 2, size.height);
    }
    
    // ImageView初始化
    _leftImageView = [[UIImageView alloc]init];
    _mainImageView = [[UIImageView alloc]init];
    _rightImageView = [[UIImageView alloc]init];
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_mainImageView];
    [_scrollView addSubview:_rightImageView];
    
    
    [self.view addSubview:_scrollView];
}

/**
 *  加载图片根据URL,并根据图片大小设置frame大小
 */
-(void)loadAndSetImage: (UIImageView *) imageView withUrlString: (NSString *) urlString{
    // 设置图片
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    UIImage *img = [UIImage imageWithData:imgData];
    [imageView setImage: img];
    
    CGFloat poxy = 0, height = 0;
    CGSize size = _scrollView.frame.size;
    if(img.size.height > size.height){
        height = size.height;
        poxy = 0;
    }else{
        height = img.size.height;
        poxy = (size.height - img.size.height)/2;
    }
    
    // 设置frame
    imageView.frame = CGRectMake(imageView.frame.origin.x, poxy, size.width, height);
}

#pragma mark 滚动视图协议实现
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if(page != _currentIndex){
        [self reloadImageView: page];
    }
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _mainImageView;
}

-(void)reloadImageView: (int)page{
    CGSize size = _scrollView.frame.size;
    CGFloat offsetX = _scrollView.contentOffset.x;
    if(page < _total - 1 && page >= 0){
        _scrollView.contentSize = CGSizeMake(offsetX + size.width * 2, 0);
        // left
        _leftImageView.frame = CGRectMake(offsetX - size.width, 0, size.width, size.height);
        // main
        _mainImageView.frame = CGRectMake(offsetX, 0, size.width, size.height);
        // right
        _rightImageView.frame = CGRectMake(offsetX + size.width, 0, size.width, size.height);
    }
    _currentIndex = page;
    
    // 添加总张数以及当前行数
    self.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex + 1, _total];
    
    // 重新设置图片
    [self loadAndSetImage:_mainImageView withUrlString:_imgurlArray[_currentIndex]];
    if((int)_currentIndex - 1 >= 0){
        [self loadAndSetImage:_leftImageView withUrlString:_imgurlArray[_currentIndex - 1]];
    }
    if((int)_currentIndex + 1 <= _total - 1){
        [self loadAndSetImage:_rightImageView withUrlString:_imgurlArray[_currentIndex + 1]];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 导航设置
    UINavigationBar *navbar = self.navigationController.navigationBar;
    navbar.translucent = YES;
    // 必须设置为可透明
    [navbar setBackgroundImage:UIIMAGE_NONE forBarMetrics:UIBarMetricsDefault];
    // 去除阴影留下的黑线
    if ([navbar respondsToSelector:@selector(shadowImage)]){
        [navbar setShadowImage:UIIMAGE_NONE];
    }
    //设置字体颜色
    [SELF_NAVBAR setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    // 导航设置
    UINavigationBar *navbar = self.navigationController.navigationBar;
    navbar.translucent = NO;
    // 必须设置为可透明
    [navbar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // 去除阴影留下的黑线
    if ([navbar respondsToSelector:@selector(shadowImage)]){
        [navbar setShadowImage:nil];
    }
    //设置字体颜色
    [SELF_NAVBAR setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [super viewWillDisappear:animated];
    AppNavigationController *nav = (AppNavigationController *)self.navigationController;
    [nav resetAppBarStyle];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
