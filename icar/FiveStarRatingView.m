//
//  FiveStarView.m
//  icar
//
//  Created by Killer on 15/11/12.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "FiveStarRatingView.h"

#define STAR_NUMBER 5
#define STAR_PADDING 2

@interface FiveStarRatingView(){
    UIView * _foregroundView;
    CGFloat _starWidth;
    CGFloat _starHeight;
}

@end

@implementation FiveStarRatingView

-(void)awakeFromNib{
    [self initWithPoint:self.frame.origin withStarSize:CGSizeMake(12, 12)];
}

-(void)initWithPoint: (CGPoint) point withStarSize: (CGSize) size{
    
    _starWidth = size.width;
    _starHeight = size.height;
    
    self.frame = CGRectMake(point.x, point.y, (_starWidth + STAR_PADDING) * STAR_NUMBER , _starHeight);
    
    UIView *backgroundView = [self createStarView:[UIImage imageNamed:@"icon_rating_star_not_picked"]];
    _foregroundView = [self createStarView:[UIImage imageNamed:@"icon_rating_star_picked"]];
    [self addSubview:backgroundView];
    [self addSubview:_foregroundView];
}

-(instancetype)initWithPoint: (CGPoint) point withStarSize: (CGSize) size withRatio: (CGFloat) ratio{
    if(self = [super init]){
        [self initWithPoint:point withStarSize:size];
        [self setRatingValue:ratio animate:NO completion:nil];
    }
    return self;
}

// 介于0 - 1之间的浮点数
-(void)setRatingValue: (CGFloat) ratio animate:(BOOL) isAnimate completion: (void (^)(BOOL finished)) completion{
    if(ratio > 1){
        ratio = 1.0f;
    }else if(ratio < 0){
        ratio = 0.0f;
    }
    
    int count = (int)(ratio * STAR_NUMBER);
    int floorWidth = count * (_starWidth + STAR_PADDING);
    int decimalWidth = ((ratio * STAR_NUMBER) - count ) * (_starWidth + STAR_PADDING);
    
    if(isAnimate){
        [UIView animateWithDuration:0.5 animations:^ {
            _foregroundView.frame = CGRectMake(0, 0, floorWidth + decimalWidth, _starHeight);
         } completion:^(BOOL finished) {
             if (completion) {
                 completion(finished);
             }
         }];
    }else{
        _foregroundView.frame = CGRectMake(0, 0, floorWidth + decimalWidth, _starHeight);
    }
}

-(UIView *)createStarView: (UIImage *) bgImage{
    UIView *bodyView = [[UIView alloc] initWithFrame:self.bounds];
    // 关键属性，裁剪子视图的超出部分
    bodyView.clipsToBounds = YES;
    int h = self.frame.size.height;
    for (int i = 0 ; i < STAR_NUMBER; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( i * (_starWidth + STAR_PADDING) , 0, _starWidth, h)];
        imgView.image = bgImage;
        
        [bodyView addSubview:imgView];
    }
    return bodyView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
