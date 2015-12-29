//
//  QuickNavCollectionView.m
//  icar
//
//  Created by Killer on 15/12/3.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "QuickNavCollectionView.h"
#import "MacroDefine.h"
#import "QuickNavCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "HomeDataLoader.h"
#import "NavigationItemModel.h"

#define QuickNavCollectionViewCellID @"QuickNavCollectionViewCell"

@interface QuickNavCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    NSArray *_navArray;
}

@end

@implementation QuickNavCollectionView

-(instancetype)initWithTop: (CGFloat) posy{
    
    // 初始化导航数据
    _navArray = [HomeDataLoader findNavItems];
    
    // 集合的布局方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    flowLayout.minimumInteritemSpacing = 1.00f;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 4) / 4, 61);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50.0f);  //设置head大小
    //flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50.0f);
    
    if(self = [self initWithFrame:CGRectMake(0, posy, SCREEN_WIDTH, 132) collectionViewLayout: flowLayout]){
        // 将nib注册到tableView队列中
        [self registerNib:[UINib nibWithNibName:QuickNavCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:QuickNavCollectionViewCellID];
        
        self.backgroundColor = THEME_WHITE_COLOR;
        self.dataSource = self;
        self.delegate = self;
        
        
    }
    return self;
}

#pragma mark 内部私有方法
-(NavigationItemModel *) getCurrentNavItemModel: (NSIndexPath *) indexPath{
    return _navArray[indexPath.section * 4 + indexPath.row];
}

#pragma mark collection协议接口实现
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
// 每个CELL的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QuickNavCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuickNavCollectionViewCellID forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor yellowColor];
    NavigationItemModel *nim =  [self getCurrentNavItemModel:indexPath];
    cell.navLabel.text = nim.iconTitle;
    [cell.navImageView setImage:[UIImage imageNamed:nim.iconUrl]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NavigationItemModel *nim =  [self getCurrentNavItemModel:indexPath];
    
    UIView *superView = self.superview;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.labelText = nim.iconTitle;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        [NSThread sleepForTimeInterval:1.5];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:superView animated:YES];
        });
    });
    
//    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"点击了：%ld",indexPath.row] delegate:nil cancelButtonTitle:@"好的，知道了" otherButtonTitles:@"需要改造了1",@"需要改造了2",@"需要改造了3", nil];
//    [view show];
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
////    if (kind == UICollectionElementKindSectionFooter){
//    
//        UICollectionReusableView *footerView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//        
//        footerView.backgroundColor = [UIColor yellowColor];
//        
//        return footerView;
//    
////    }
//    
//    
//}


@end
