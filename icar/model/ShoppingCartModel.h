//
//  ShoppingCartModel.h
//  icar
//
//  Created by Killer on 15/11/23.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject
// 产品编号
@property(nonatomic, assign) NSUInteger prodId;
// 产品名称
@property(nonatomic, strong) NSString *prodName;
// 产品图片
@property(nonatomic, strong) NSString *prodCartImage;
// 市场价
@property(nonatomic, assign) float prodMarketPrice;

// 现价
@property(nonatomic, assign) float buyPrice;
// 购买数量
@property(nonatomic, assign) int buyCount;
//TODO: 选择的类型描述，临时这么用
@property(nonatomic, strong) NSString *selectedDesc;


/** 附加的属性：平台不用关心该属性值 ***/
@property(nonatomic, assign) BOOL checked;

/** 产品服务项目 */
@property(nonatomic, strong) NSArray *serviceItems;

@end
