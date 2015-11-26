//
//  ShoppingCartTableViewCell.m
//  icar
//
//  Created by Killer on 15/11/20.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
@interface ShoppingCartTableViewCell (){
    ShoppingCartModel *_scm;
}
@end

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 复选框按钮单击事件
    _radioImageView.userInteractionEnabled = YES;
    [_radioImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCheckBoxClick:)]];
    _editSelectedDescLabel.font = [UIFont systemFontOfSize:10];
    _prodPriceLabel.font = [UIFont systemFontOfSize:17];
}

#pragma mark Outlet点击事件处理
- (IBAction)didEditMinusClick:(id)sender {
    [self calcCounter:-1];
}
- (IBAction)didEditPlusClick:(id)sender {
    [self calcCounter:1];
}
-(void)didCheckBoxClick:(id)tapGen{
    _scm.checked = !_scm.checked;
    [self resetBoxCheckedState];
    // 重新计算结算总金额
    [_parent doResetTotalFee];
}

-(void)loadCellDataWithShoppingCartModel:(ShoppingCartModel *)scm{
    _scm = scm;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:scm.prodCartImage]];
    [_prodImageView setImage:[UIImage imageWithData:data]];
    _prodTitleLabel.text = scm.prodName;
    _editSelectedDescLabel.text = scm.selectedDesc;
    [self resetDisplayBuyCount];
    [self resetBoxCheckedState];
}

#pragma mark 私有方法
-(void)resetBoxCheckedState{
    if(_scm.checked){
        [_radioImageView setImage:[UIImage imageNamed:@"icon_radio_on"]];
    }else{
        [_radioImageView setImage:[UIImage imageNamed:@"icon_radio"]];
    }
}

-(void)resetDisplayBuyCount{
    _buyCountLabel.text = [NSString stringWithFormat:@"%d", _scm.buyCount];
    [_editCountBtn setTitle:[NSString stringWithFormat:@"%d",_scm.buyCount] forState:UIControlStateNormal];
    // 价格
    _prodPriceLabel.text = [NSString stringWithFormat:@"%.2f", _scm.buyPrice];
}
-(void)calcCounter: (int) value{
    int newValue = _scm.buyCount + value;
    // 至少一件
    if(newValue < 1){ return ; }
    
    _scm.buyCount = newValue;
    [self resetDisplayBuyCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
