//
//  ProdEvaluationView.m
//  icar
//
//  Created by Killer on 15/11/11.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProdEvaluationView.h"
#import "MacroDefine.h"
#import "MixedUtils.h"
#import "ProdEvaluateTableViewCell.h"
#import "FiveStarRatingView.h"
#import "ViewUtils.h"
#import "UIView+Border.h"
#import "TemplateUtil.h"
#import "AutoTextMarkView.h"
#import "ImageBrowserViewController.h"

@interface ProdEvaluationView () <UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *_tableView;
    NSArray *_dataArray;
    
    UIViewController *_parentVC;
}

@end

@implementation ProdEvaluationView

-(instancetype)initWithPosy:(CGFloat) posy withParent: (UIViewController *) parent{
    if(self = [super initWithFrame:CGRectMake(0, posy, SCREEN_WIDTH, 400)]){

        _parentVC = parent;
        self.backgroundColor = [UIColor whiteColor];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 40)];
        label.text = [NSString stringWithFormat:@"商品评价（%d）",  [MixedUtils getRandomNumber:1 to:9999]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = THEME_COLOR_NORMAL_OBJ;
        
        FiveStarRatingView *ratingView = [[FiveStarRatingView alloc]initWithPoint:CGPointMake(SCREEN_WIDTH - 126, 13) withStarSize:CGSizeMake(12, 12) withRatio:.9f];
        [self addSubview:ratingView];
        
        UILabel *totalScore = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH - 46, 0, 40, 40)];
        totalScore.text = @"4.5分";
        totalScore.font = [UIFont systemFontOfSize:13];
        totalScore.textColor = THEME_COLOR_NORMAL_OBJ;
        [self addSubview:totalScore];
        
        
        AutoTextMarkView *atmv = [[AutoTextMarkView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 100) fontSize:14];
        [atmv addMarkWithArray:@[@"态度不错(783)",@"质量不错(763)",@"实惠(448)",@"快递不错(332)",@"功能正面(44)",@"测试的一个标签(99)"] withTags:@[@100,@101,@102,@103,@104,@106] bgColor:THEME_COLOR_HIGHLIGHTED_ORAGE_OBJ];
        
        [atmv addMarkWithArray:@[@"质量一般(9)",@"服务态度差(15)"] withTags:@[@107,@108] bgColor:[UIColor grayColor]];
        
//        [atmv addTopBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.8];
        
        CGFloat _height = [atmv adjustAutoHeight];
        [self addSubview:atmv];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _height + 45, self.frame.size.width, 514.8) style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = THEME_COLOR_BORDER_OBJ;
        
        [self addSubview:label];
        [self addSubview:_tableView];
        
        
        [self addTopBorderWithColor:THEME_COLOR_BORDER_OBJ andWidth:.5];
        
    }
    return self;
}

#pragma make 表格代理实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 55;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [TemplateUtil view:CGRectMake(0, 0, tableView.frame.size.width, 55) bgColor:[UIColor whiteColor] borderColor:THEME_COLOR_BORDER_OBJ border:TBorderMake(0, 0, .6, 0)];
    
    CGRect frame = CGRectMake(tableView.frame.size.width/2 - 55, 12, 110, 30);
    UIButton *viewAllBtn = [TemplateUtil button:@"查看全部评论" fontSize:13 color:THEME_COLOR_NORMAL_OBJ frame:frame radius:3.0 border:1 borderColor:THEME_COLOR_BORDER_OBJ bgColor:nil];
    [footerView addSubview:viewAllBtn];
    
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ProdEvaluateTableViewCell";
    ProdEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        // 将nib注册到tableView队列中
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        // 从队列中重新获取Cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
    }
    FiveStarRatingView *starView = (FiveStarRatingView *)cell.starRatingParentView;
    [starView setRatingValue:0.65f animate:NO completion:nil];
    
    FlowLayoutView *flowView = [self createImagesView: tableView.frame.size.width - 30];
    [cell.shareImageParentView addSubview:flowView];
    
    CGFloat height = [flowView getAutoHeight];
    cell.shareImageParentView.frame = CGRectMake(cell.shareImageParentView.frame.origin.x, cell.shareImageParentView.frame.origin.y, tableView.frame.size.width, height);
    
    //cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(FlowLayoutView *) createImagesView: (CGFloat) width{
    // 评论图片
    NSArray *imgUrls = [self getImageData];
    
    FlowLayoutView *flowView = [[FlowLayoutView alloc] initWithFrame:CGRectMake(0, 0, width, 0) hpadding:5 vpadding:5 startPosx:0];
    
    int imgWidth = (width - 5 * 4 ) / 4.0;
    for (int i =0 ; i < imgUrls.count; i ++) {
        UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
        btnView.frame = CGRectMake((imgWidth + 5) * i , 0, imgWidth, imgWidth);
        NSURL *url = [NSURL URLWithString:imgUrls[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [btnView setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        [btnView addTarget:self action:@selector(openImageBrowser:) forControlEvents:UIControlEventTouchUpInside];
        
        [flowView addSubview:btnView];
    }
    [flowView adjustAutoHeight];
    
    return flowView;
}

-(void)openImageBrowser:(id) imageView{
    [ImageBrowserViewController openImageBrowser:_parentVC withUrls:[self getImageData] backHideBottom:YES];
}

-(NSArray *) getImageData {
    NSArray *imgUrls = @[@"https://img.alicdn.com/bao/uploaded/i2/137350130412022891/TB1kj74JVXXXXcXXFXXXXXXXXXX_!!0-rate.jpg_400x400.jpg",@"https://img.alicdn.com/bao/uploaded/i2/137350130412029293/TB1zHFdKXXXXXbuXpXXXXXXXXXX_!!0-rate.jpg_400x400.jpg",@"https://img.alicdn.com/bao/uploaded/i2/111930134714283567/TB2ogzEgFXXXXaeXXXXXXXXXXXX_!!0-rate.jpg_400x400.jpg",@"https://img.alicdn.com/bao/uploaded/i2/111930134714232718/TB2KO6cgFXXXXbmXpXXXXXXXXXX_!!0-rate.jpg_400x400.jpg"];
    
    return imgUrls;
}

@end
