//
//  JLCarouselView.m
//  icar
//
//  Created by Killer on 15/11/5.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "JLCarouselView.h"

@interface JLCarouselView () <UIScrollViewDelegate>{
    NSInteger _pages;
    NSTimer * _timer;
}

@end

@implementation JLCarouselView

-(instancetype) initWithFrame:(CGRect)frame withPages:(NSInteger ) pages{
    if(self = [super initWithFrame:frame]){
        _pages = pages;
        [self initRequiredView];
    }
    
    return self;
}

-(void)addToScrollView:(UIView *) singleView{
    if(singleView){
        [_scrollView addSubview:singleView];
    }
}

-(void)initRequiredView{
    int bodyWidth = self.frame.size.width, bodyHeight = self.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, bodyWidth, bodyHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(bodyWidth * _pages, bodyHeight);
    
    int height = 16, padding = 10, width = 80;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((bodyWidth - width)/2, bodyHeight - height - padding, width, height)];
    _pageControl.layer.cornerRadius = 4;
    _pageControl.numberOfPages = _pages;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.145 green:0.682 blue:0.722 alpha:1.000];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

#pragma make 滚动协议
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}
//拖拽时不允许自动播放
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(_timer){
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timer.timeInterval]];
    }
}

-(void)playNextView{
    NSUInteger curr = _pageControl.currentPage;
    NSUInteger next = (_pages == ++curr) ? 0 : curr;
    
//    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * next, 0);
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * next, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    _pageControl.currentPage = next;
}

-(void)startTimer: (NSTimeInterval) interval{
    if(!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(playNextView) userInfo:nil repeats:YES];
    }else{
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
    
}
-(void)stopTimer{
    if(_timer){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
