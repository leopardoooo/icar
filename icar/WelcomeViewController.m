//
//  WelcomeViewController.m
//  icar
//
//  Created by Killer on 15/12/7.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MacroDefine.h"

@interface WelcomeViewController () <UIScrollViewDelegate>{
    UIScrollView *_scrollView;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    //_scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addScrollImage];
    
    [self.view addSubview:_scrollView];
}

-(void)addScrollImage{
    CGFloat width = _scrollView.frame.size.width, height = _scrollView.frame.size.height;
    //FIXME: 需要替换成引导图片代替颜色卡片
    NSArray *dataArray = @[[UIColor colorWithRed:1.000 green:0.800 blue:0.400 alpha:0.500],[UIColor colorWithRed:0.800 green:1.000 blue:0.400 alpha:0.500],[UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:0.500],[UIColor colorWithWhite:0.800 alpha:1.000]];
    _scrollView.contentSize = CGSizeMake( dataArray.count * width, 0);
    // 添加内容卡片
    for (int i = 0 ; i < dataArray.count; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.backgroundColor = dataArray[i];
        [imageView addSubview: [self newLabel:[NSString stringWithFormat:@"%d/%ld",i + 1, dataArray.count]]];
        [_scrollView addSubview:imageView];
    }
    
    // 体验按钮
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake((dataArray.count - 1) * width + (width - 120)/2, height - 120, 120, 36);
    openBtn.layer.borderColor = [UIColor redColor].CGColor;
    openBtn.layer.borderWidth = 2;
    openBtn.layer.cornerRadius = 4;
    [openBtn setTitle:@"马上体验" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openHomeViewController) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:openBtn];
}

-(UILabel *) newLabel: (NSString *) text{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.frame = CGRectMake(_scrollView.frame.size.width - 60, 60, 36, 36);
    label.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 18;
    label.layer.masksToBounds = YES;
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1, 1);
    return label;
}

-(void)openHomeViewController{
    _window.rootViewController = _rootViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [super viewWillAppear:animated];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//}

@end
