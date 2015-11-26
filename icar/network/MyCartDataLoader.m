//
//  MyCartDataLoader.m
//  icar
//
//  Created by Killer on 15/11/23.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "MyCartDataLoader.h"
#import "ShoppingCartModel.h"

@implementation MyCartDataLoader


+(NSArray *)queryMyShoppingCarts{
    
    ShoppingCartModel *scm1 = [[ShoppingCartModel alloc] init];
    scm1.prodId = 1001;
    scm1.prodName = @"潮妈孕妇装2015秋冬新款T恤长袖女韩版中长款加绒加厚大码打底衫";
    scm1.prodCartImage = @"https://img.alicdn.com/bao/uploaded/i2/TB1LKd5KFXXXXaJXFXXXXXXXXXX_!!0-item_pic.jpg_80x80.jpg";
    scm1.prodMarketPrice = 260;
    scm1.buyCount = 1;
    scm1.buyPrice = 118.3;
    scm1.selectedDesc = @"颜色分类：紫罗兰；尺码：M";
    
    ShoppingCartModel *scm2 = [[ShoppingCartModel alloc] init];
    scm2.prodId = 1002;
    scm2.prodName = @"孕妇毛衣宽松套头韩版上衣短款海马毛时尚长袖打底外穿保暖产后装";
    scm2.prodCartImage = @"https://img.alicdn.com/bao/uploaded/i1/731636673/TB2XJugfVXXXXb.XpXXXXXXXXXX_!!731636673.jpg_80x80.jpg";
    scm2.prodMarketPrice = 218;
    scm2.buyCount = 1;
    scm2.buyPrice = 98;
    scm2.selectedDesc = @"颜色分类：紫罗兰；尺寸：均码";
    
    ShoppingCartModel *scm3 = [[ShoppingCartModel alloc] init];
    scm3.prodId = 1003;
    scm3.prodName = @"特价百香果西番莲百香果批发热带水果新鲜海南水果美白中等果包邮";
    scm3.prodCartImage = @"https://img.alicdn.com/bao/uploaded/i2/TB1b4x3KpXXXXXQXVXXXXXXXXXX_!!0-item_pic.jpg_80x80.jpg";
    scm3.prodMarketPrice = 60;
    scm3.buyCount = 1;
    scm3.buyPrice = 40;
    scm3.selectedDesc = @"";
    
    ShoppingCartModel *scm4 = [[ShoppingCartModel alloc] init];
    scm4.prodId = 1001;
    scm4.prodName = @"韩束护手霜套装 秋冬季补水保湿滋润去死皮 嫩手膜润手霜包邮正品";
    scm4.prodCartImage = @"https://img.alicdn.com/bao/uploaded/i3/TB1g5THGpXXXXbtXVXXXXXXXXXX_!!0-item_pic.jpg_80x80.jpg";
    scm4.prodMarketPrice = 79;
    scm4.buyCount = 2;
    scm4.buyPrice = 79;
    scm4.selectedDesc = @"化妆品净含量：80g";
    
    
    return [[NSArray alloc] initWithObjects:scm1, scm2, scm3, scm4, nil];
}

@end
