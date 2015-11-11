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

@interface ProductDetailViewController (){
    ProductResultModel * _product;
    
    ProdSpecTableView *_specTableView;
}

@end

@implementation ProductDetailViewController

// 初始化当前类必须要一个产品数据
-(instancetype)initWithProduct: (ProductResultModel *) prm{
    if(self = [super init]){
        _product = prm;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *root = [[UIScrollView alloc] initWithFrame:self.view.frame];
    root.contentSize = CGSizeMake(SELF_SIZE_WIDTH, SELF_SIZE_HEIGHT * 2);
    self.view = root;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];
    self.title = @"商品详情";
    
    [self createRightTools];
    [self createProdScrollImage];
    
    // 商品信息
    UIView *prodView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SELF_SIZE_WIDTH, 118)];
    prodView.backgroundColor = [UIColor whiteColor];
    [self createTitleAndIcon:prodView];
    [self createPriceInfo:prodView];
    [self.view addSubview:prodView];
    
    [prodView addBottomBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.5];
    
    // 动态listView
    _specTableView = [[ProdSpecTableView alloc] initWithFrame:CGRectMake(0, 428, SELF_SIZE_WIDTH, 70)];
    [self.view addSubview:_specTableView];
    
    // 商品评价
    ProdEvaluationView *evaluationView = [[ProdEvaluationView alloc]initWithPosy:510];
    [self.view addSubview:evaluationView];
    
}

// 创建导航栏右边按钮
-(void)createRightTools{
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(0, 5, 20, 20);
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    collectBtn.frame = CGRectMake(40, 5, 20, 20);
    
    [toolsView addSubview:shareBtn];
    [toolsView addSubview:collectBtn];
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:toolsView] ;
}

// 创建商品图片视图
-(void)createProdScrollImage{
    NSArray *imgArray = @[@"https://img.alicdn.com/bao/uploaded/i1/TB1A96uKpXXXXX4XXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i3/T1sgbmFCXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2CoWBgFXXXXXpXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2o3azgFXXXXXEXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg",@"https://img.alicdn.com/imgextra/i1/1984719051/TB2mpWmgFXXXXcXXXXXXXXXXXXX_!!1984719051.jpg_430x430q90.jpg"];
    JLCarouselView *imgCarouselView = [[JLCarouselView alloc] initWithFrame:CGRectMake(0, 0, SELF_SIZE_WIDTH, 300) withPages:imgArray.count];
    imgCarouselView.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.910 alpha:0.900];
    int w = imgCarouselView.frame.size.width, h = imgCarouselView.frame.size.height;
    for (int i = 0 ; i < imgArray.count; i++) {
        NSURL *url = [NSURL URLWithString:imgArray[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(w * i, 0, w, h)];
        [imgView setImage:img];
        [imgCarouselView addToScrollView: imgView];
    }
    imgCarouselView.pageControl.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.015];
    imgCarouselView.pageControl.frame = CGRectMake(0, imgCarouselView.frame.size.height - 40, imgCarouselView.frame.size.width, 40);
    imgCarouselView.pageControl.layer.cornerRadius = 0;
    
    [self.view addSubview:imgCarouselView];
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

@end
