//
//  ProductDetailViewController.m
//  icar
//
//  Created by Killer on 15/11/10.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductResultModel.h"
#import "JLCarouselView.h"
#import "MacroDefine.h"
#import "UIView+Border.h"
#import "ViewUtils.h"
#import "MixedUtils.h"
#import "ProdSpecTableView.h"
#import "ProdEvaluationView.h"
#import "FiveStarRatingView.h"
#import "ImageBrowserViewController.h"
#import "ProductBuyBarView.h"
#import "SplitLineLabelView.h"
#import "SimpleWebView.h"

@interface ProductDetailViewController (){
    ProductResultModel * _product;
    ProdSpecTableView * _specTableView;
    ProductBuyBarView * _buyBarView;
    ProdEvaluationView *_evaluationView;
    UIButton *_collectBtn;
    UIButton *_shareBtn;
    UIScrollView *_rootView;
    BOOL _collectMark;
}

@end

@implementation ProductDetailViewController

/* 打开一个产品详情控制器，应该都通过这个静态方法打开，因为该方法除了实例化一个控制器, 还会隐藏底部TabBar
 */
+(void)openProductDetailViewController: (UIViewController *) target withProduct: (ProductResultModel *) prm{
    target.hidesBottomBarWhenPushed = YES;
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithProduct:prm];
    [target.navigationController pushViewController:vc animated:YES];
    target.hidesBottomBarWhenPushed = NO;
}

// 初始化当前类必须要一个产品数据
-(instancetype)initWithProduct: (ProductResultModel *) prm{
    if(self = [super init]){
        _product = prm;
        _collectMark = [MixedUtils getRandomNumber:0 to:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT - APP_STATUSBAR_SIZE.height - SELF_NAVBAR.frame.size.height - 45)];
    _rootView.contentSize = CGSizeMake(SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT * 3);
    [self.view addSubview:_rootView];
    
    _rootView.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];
    self.title = @"商品详情";
    
    [self createRightTools];
    [self createProdScrollImage];
    
    // 商品信息
    UIView *prodView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SELF_SIZE_WIDTH, 118)];
    prodView.backgroundColor = [UIColor whiteColor];
    [self createTitleAndIcon:prodView];
    [self createPriceInfo:prodView];
    [_rootView addSubview:prodView];
    
    [prodView addBottomBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.5];
    
    // 动态listView
    _specTableView = [[ProdSpecTableView alloc] initWithFrame:CGRectMake(0, 428, SELF_SIZE_WIDTH, 70)];
    [_rootView addSubview:_specTableView];
    
    // 商品评价
    _evaluationView = [[ProdEvaluationView alloc]initWithPosy:510 withParent:self];
    [_rootView addSubview:_evaluationView];
    
    // 图文详情
    SplitLineLabelView *lineView = [[SplitLineLabelView alloc] initWithFrame:CGRectMake(15, 510 + 660, SELF_SIZE_WIDTH - 30, 40) withTitle:@"继续拖动，查看图文详情" bgColor: _rootView.backgroundColor lineColor:[UIColor colorWithWhite:0.776 alpha:1.000] titleColor:[UIColor colorWithWhite:0.208 alpha:1.000]];
    [_rootView addSubview:lineView];
    
    // WebView
    SimpleWebView *webView = [[SimpleWebView alloc]initWithFrame:CGRectMake(0, 510 + 660 + 40, SELF_SIZE_WIDTH, 10)];
    [_rootView addSubview:webView];
    [webView loadRequestWithString:@"http://h5.m.jd.com/active/download/download.html?source=RankingMain"];
    
    // 底部购买栏
    _buyBarView = [[ProductBuyBarView alloc] initWithParent:self withProduct:_product];
    [self.view addSubview:_buyBarView];
}

// 创建导航栏右边按钮
-(void)createRightTools{
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    _shareBtn.frame = CGRectMake(0, 5, 20, 20);
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBtn.frame = CGRectMake(40, 5, 20, 20);
    [_collectBtn addTarget:self action:@selector(didCollectProd:) forControlEvents:UIControlEventTouchUpInside];
    [self toggleCollectIcon];
    
    [toolsView addSubview:_shareBtn];
    [toolsView addSubview:_collectBtn];
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:toolsView] ;
}

// 创建商品图片视图
-(void)createProdScrollImage{
    NSArray *imgArray = [self getScrollProdImages];
    JLCarouselView *imgCarouselView = [[JLCarouselView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, 300) withPages:imgArray.count];
    imgCarouselView.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.910 alpha:0.900];
    int w = imgCarouselView.frame.size.width, h = imgCarouselView.frame.size.height;
    for (int i = 0 ; i < imgArray.count; i++) {
        NSURL *url = [NSURL URLWithString:imgArray[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
        btnView.frame = CGRectMake(w * i, 0, w, h);
        [btnView addTarget:self action:@selector(openImageBrowser:) forControlEvents:UIControlEventTouchUpInside];
        [btnView setImage:img forState:UIControlStateNormal];
        [imgCarouselView addToScrollView: btnView];
    }
    imgCarouselView.pageControl.frame = CGRectMake(0, imgCarouselView.frame.size.height - 40, imgCarouselView.frame.size.width, 40);
    imgCarouselView.pageControl.layer.cornerRadius = 0;
    
    [_rootView addSubview:imgCarouselView];
}

//创建标题
-(void)createTitleAndIcon: (UIView *)superView{
    int rw = 60, h = 60;
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - rw, 0, rw, h)];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(rw/2 - 15, h/2 - 15, 30 ,30);
    [detailBtn setImage:[UIImage imageNamed:@"icon_cate_normal_-1"] forState:UIControlStateNormal];
    [iconView addSubview:detailBtn];
    [superView addSubview:iconView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, SCREEN_WIDTH - rw - 11, h - 14)];
    [titleLabel setText:_product.title];
    [titleLabel setNumberOfLines:2];
    
    UIView *splitLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - rw, 5, .5, h - 10)];
    splitLineView.backgroundColor = THEME_COLOR_BORDER_OBJ;
    
    [superView addSubview:splitLineView];
    [superView addSubview:titleLabel];
}

// 创建价格信息UI
-(void)createPriceInfo: (UIView *) superView{
    int h = 80;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, h)];
    
    // 销售价
    UILabel *markLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 11, 15, 15)];
    markLabel.text = @"￥";
    markLabel.textColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    [view addSubview:markLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, 200, 26)];
    priceLabel.text = [NSString stringWithFormat:@"%d",[MixedUtils getRandomNumber:1000 to:4999]];
    priceLabel.font = [UIFont systemFontOfSize:25];
    priceLabel.textColor = THEME_COLOR_HIGHLIGHTED_OBJ;
    [view addSubview:priceLabel];
    
    // 市场价
    UILabel *markLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 32, 40, 25)];
    markLabel2.text = @"专柜价";
    markLabel2.textColor = THEME_COLOR_NORMAL_OBJ;
    markLabel2.font = [UIFont systemFontOfSize:12];
    [view addSubview:markLabel2];
    
    UILabel *mallPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 32, 100, 25)];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%d",[MixedUtils getRandomNumber:5000 to:9999]];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:oldPrice
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:12],
       NSForegroundColorAttributeName:THEME_COLOR_NORMAL_OBJ,
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:THEME_COLOR_NORMAL_OBJ}];
    mallPriceLabel.attributedText = attrStr;
    [view addSubview:mallPriceLabel];
    
    
    [superView addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) getScrollProdImages{
    NSArray *imgArray = @[@"https://img.alicdn.com/bao/uploaded/i1/TB1A96uKpXXXXX4XXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i3/T1sgbmFCXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2CoWBgFXXXXXpXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2o3azgFXXXXXEXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2mpWmgFXXXXcXXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg"];
    
    return imgArray;
}

-(void)openImageBrowser: (id) sender{
    [ImageBrowserViewController openImageBrowser:self withUrls:[self getScrollProdImages] backHideBottom:YES ];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark 事件方法实现
-(void)didCollectProd: (UIButton *)btn{
    _collectMark = !_collectMark;
    [self toggleCollectIcon];
    [ViewUtils showMessage:_collectMark ? @"成功收藏":@"取消完成"];
}
// 根据当前的收藏标志设置显示图标
-(void)toggleCollectIcon{
    if(_collectMark){
        [_collectBtn setImage:[UIImage imageNamed:@"iocn_merchant_collect_highlighted"] forState:UIControlStateNormal];
    }else{
        [_collectBtn setImage:[UIImage imageNamed:@"iocn_merchant_collect_normal"] forState:UIControlStateNormal];
    }
}

@end
