//
//  ProductTableView.m
//  icar
//
//  Created by Killer on 15/11/9.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ProductTableView.h"
#import "ProductTableViewCell.h"
#import "ProductResultModel.h"
#import "MixedUtils.h"
#import "ProductDetailViewController.h"
#import "MJRefresh.h"
#import "ProductDataLoader.h"
#import "UIImageView+WebCache.h"
#import "MacroDefine.h"
#import "ViewUtils.h"

#define ProductViewController_LOAD_LIMIT 15
#define ProductViewController_PAGE_INFO_FONT_SIZE 10

@interface ProductTableView ()<UITableViewDelegate, UITableViewDataSource>{
    UIViewController * _parent;
    Pager *_lastPage;
    UILabel * _pageInfoLabel;
}

@end

@implementation ProductTableView


-(instancetype)initWithFrame:(CGRect)frame parent: (UIViewController *) parent{
    if(self = [self initWithFrame:frame style:UITableViewStyleGrouped]){
        _parent = parent;
        
        self.dataSource = self;
        self.delegate = self;
        
        _dataArray = [[NSMutableArray alloc] init];
        
        __unsafe_unretained __typeof(self) weakSelf = self;
        // 上拉加载更多
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            NSInteger newStart =  _lastPage.start + _lastPage.limit;
            [weakSelf loadTableDataWithStart:_lastPage ? newStart : 0 done:^{
                [weakSelf.mj_footer endRefreshing];
            }];
        }];
        // 下拉重新开始刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadTableDataWithStart: 0 done:^{
                [weakSelf.mj_header endRefreshing];
            }];
        }];
        
        // 设置文字
        self.mj_footer = footer;
        
        // 分页信息浮层
        _pageInfoLabel = [[UILabel alloc] init];
        _pageInfoLabel.textAlignment = NSTextAlignmentCenter;
        _pageInfoLabel.alpha = 0;
        _pageInfoLabel.backgroundColor = [UIColor colorWithWhite:0.098 alpha:0.510];
        _pageInfoLabel.textColor = THEME_WHITE_COLOR;
        _pageInfoLabel.font = [UIFont systemFontOfSize:ProductViewController_PAGE_INFO_FONT_SIZE];
        _pageInfoLabel.layer.cornerRadius = 3;
        _pageInfoLabel.layer.masksToBounds = YES;
        [self addSubview:_pageInfoLabel];
    }
    return self;
}

-(void) firstLoadTableData {
    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
}

#pragma mark table上下滚动事件重写
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(_lastPage){
        _pageInfoLabel.alpha = 1;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(_lastPage){
        [UIView animateWithDuration:2.0 animations:^{
            _pageInfoLabel.alpha = 0;
        }];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath *lastIndexPath = [[self indexPathsForVisibleRows] firstObject];
    NSString *pageInfo = [NSString stringWithFormat:@"%ld / %ld", lastIndexPath.row + 1, _lastPage.totalCount];
    CGSize size = [ViewUtils sizeWithSingleLine:pageInfo fontSize:ProductViewController_PAGE_INFO_FONT_SIZE];
    // 左右间距，上下间距
    CGFloat width = size.width + 8, height = size.height + 6;
    _pageInfoLabel.text = pageInfo;
    _pageInfoLabel.frame = CGRectMake((self.frame.size.width - width)/2, self.frame.size.height - height - 60 + scrollView.contentOffset.y, width , height);
}

#pragma mark 加载数据
-(void)loadTableDataWithStart: (NSInteger) start done: (void (^)(void)) done{
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 异步加载数据
    [ProductDataLoader queryProdList:start withLimit:ProductViewController_LOAD_LIMIT success:^(Pager *page) {
        done();
        _lastPage = page;
        if(start == 0){
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray: page.records];
        [weakSelf reloadData];
    } failure:^{
        NSLog(@"网络繁忙，请稍后在试试!");
        done();
    }];
}

#pragma make 表格代理实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    int width = tableView.frame.size.width - 20, height =  36;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width - 50, height)];
    positionLabel.text = @"杭州西湖区萍水西街优盘时代中心4号楼";
    positionLabel.font = [UIFont systemFontOfSize:13];
    positionLabel.textColor = [UIColor colorWithWhite:0.316 alpha:1.000];
    [view addSubview: positionLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(width - 6 , 12, 16, 16);
    [btn setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    
    [view addSubview:btn];
    
    view.backgroundColor = [UIColor colorWithWhite:0.967 alpha:1.000];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ProductTableViewCell";
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        // 将nib注册到tableView队列中
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        // 从队列中重新获取Cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        cell.bigImageView.layer.masksToBounds = YES;
        cell.bigImageView.layer.cornerRadius = 2.0;
        cell.priceLabel.font = [UIFont systemFontOfSize:17];
    }
    ProductResultModel *prm = _dataArray[ indexPath.row];
    cell.titleLabel.text = prm.prodName;
    cell.priceLabel.text = [NSString stringWithFormat:@"%d",[MixedUtils getRandomNumber:10 to:9999]];
    cell.commentLabel.text = [NSString stringWithFormat:@"%d", [MixedUtils getRandomNumber:10 to:9999]];
    //FIXME: 改用异步加载数据
    NSURL *url = [NSURL URLWithString:prm.prodImageUrl];
    [cell.bigImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_merchant_photo_placeholder_small"]];
    
    UIImage *img1 = [UIImage imageNamed:@"icon_deal_ guarantee"];
    UIImage *img2 = [UIImage imageNamed:@"icon_deal_mainpush"];
    UIImage *img3 = [UIImage imageNamed:@"icon_deal_exclusive"];
    UIImage *img4 = [UIImage imageNamed:@"ic_deal_noBooking"];
    NSArray *markImgs = @[img1, img2, img3, img4];
    int index = [MixedUtils getRandomNumber:0 to:6];
    if(index <= markImgs.count - 1){
        cell.markImageView.hidden = NO;
        cell.markImageView.image = markImgs[index];
    }
    
    return cell;
}

//点击进入详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductResultModel *prm = _dataArray[indexPath.row];
    [ProductDetailViewController openProductDetailViewController:_parent withProduct:prm];
}

@end
