//
//  ConfirmOrderTableViewCell.m
//  icar
//
//  Created by Killer on 15/11/24.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"
#import "MacroDefine.h"



@interface ConfirmOrderTableViewCell() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    UITableView *_tableView;
    ShoppingCartModel *_scm;
}

@end

@implementation ConfirmOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 嵌套表格
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 15);
    _tableView.separatorColor = THEME_COLOR_BORDER_OBJ;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
}

//加载列数据，修改显示
-(void)loadCellWithData:(ShoppingCartModel *)scm{
    _scm = scm;
    
    _prodNameLabel.text = scm.prodName;
    _buyPriceLabel.text = [NSString stringWithFormat:@"%.2f",scm.buyPrice];
    _buyCountLabel.text = [NSString stringWithFormat:@"x%d", scm.buyCount];
    
    _prodSelectedDescLabel.text = scm.selectedDesc;
    _subTotalFeeLabel.text = [NSString stringWithFormat:@"%.2f", scm.buyPrice * scm.buyCount];
    
    // 加载图片
    _prodImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:scm.prodCartImage]]];
    // 设置表格frame
    _tableView.frame = CGRectMake(0, _prodInfoContentView.frame.size.height, SCREEN_WIDTH, _scm.serviceItems.count * ConfirmOrderTableViewCell_ROW_HEIGHT);
}


#pragma mark tableView协议接口实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _scm.serviceItems.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ConfirmOrderTableViewCell_ROW_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"ConfirmOrderTableViewCellInnerTableViewCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    NSArray *item = _scm.serviceItems[indexPath.row];
    if([item[2] isEqual:@"link"]){
        cell.textLabel.text = item[0];
        cell.detailTextLabel.text = item[1];
        // 箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@:", item[0]];
        float width = cell.contentView.frame.size.width - 90;
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, width, ConfirmOrderTableViewCell_ROW_HEIGHT)];
        field.font = [UIFont systemFontOfSize:13];
        field.keyboardType = UIKeyboardTypeDefault;
        field.text = item[1];
        field.delegate = self;
        field.placeholder = @"填写公司名称或个人姓名";
        [cell.contentView addSubview: field];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
