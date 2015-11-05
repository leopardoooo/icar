//
//  MyPrivateViewController.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "MyPrivateViewController.h"
#import "MacroDefine.h"

@interface MyPrivateViewController ()

@end

@implementation MyPrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    
    
}

-(void) initNavigationBar
{
    [self initNavigationBarLeftItem];
    [self initNavigationBarRightItem];
    [self initNavigationBarBackItem];
    [self initUserBriefView];
}

-(void) initUserBriefView
{
    
}

-(void) initNavigationBarBackItem
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
}
-(void) initNavigationBarLeftItem
{
    CGRect frame = self.navigationController.navigationBar.frame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, frame.size.height)];
    label.text = @"我的";
    [label setTextColor:[UIColor colorWithWhite:0.40 alpha:1.0]];
    label.font = [UIFont boldSystemFontOfSize:18];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc ] initWithCustomView:label];
//    [self.navigationItem setLeftBarButtonItem:item];
    [self.navigationController.navigationBar addSubview:label];
}

-(void) initNavigationBarRightItem
{
    CGRect frame = self.navigationController.navigationBar.frame;
    
    //account button
    UIButton* accountButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-150,0,30,30)];
    [accountButton setImage:[UIImage imageNamed:@"icon_mine_account_setting_normal@2x.png"]forState:UIControlStateNormal];
    accountButton.highlighted = YES;
    [accountButton addTarget:self action:@selector(enterAccount)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightAccountItem = [[UIBarButtonItem alloc]initWithCustomView:accountButton];
    
    //message button
    UIButton* messageButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-50,0,30,30)];
    [messageButton setImage:[UIImage imageNamed:@"icon_message@2x.png"]forState:UIControlStateNormal];
    messageButton.highlighted = YES;
    [messageButton addTarget:self action:@selector(enterMessage)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightMessageItem = [[UIBarButtonItem alloc]initWithCustomView:messageButton];
    NSArray * btnArr = @[rightMessageItem,rightAccountItem];
    self.navigationItem.rightBarButtonItems=btnArr;
    
//    self.navigationItem.xxxItem.customView.hidden =YES;
    
}

-(void) enterAccount
{
    NSLog(@"enter account");
}

-(void) enterMessage
{
    NSLog(@"enter message");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
