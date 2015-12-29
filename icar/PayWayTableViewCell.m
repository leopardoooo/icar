//
//  PayWayTableViewCell.m
//  icar
//
//  Created by Killer on 15/11/26.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "PayWayTableViewCell.h"

@implementation PayWayTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setCheckStateView:(BOOL)state{
    if(state){
        _checkBox.image = [UIImage imageNamed:@"icon_radio_on"];
    }else{
        _checkBox.image = [UIImage imageNamed:@"icon_radio"];
    }
}


@end
