//
//  ProductDetailViewController.h
//  icar
//
//  Created by Killer on 15/11/10.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ProductResultModel;

@interface ProductDetailViewController : UIViewController

+(void)openProductDetailViewController: (UIViewController *) target withProduct: (ProductResultModel *) prm;

-(instancetype)initWithProduct: (ProductResultModel *) prm;

@end
