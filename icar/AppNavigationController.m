//
//  AppNavigationController.m
//  icar
//
//  Created by Killer on 15/11/4.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "AppNavigationController.h"
#import "MacroDefine.h"

@interface AppNavigationController ()

@end

@implementation AppNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    [self resetAppBarStyle];
}

-(void)resetAppBarStyle{
    self.navigationBar.barTintColor = THEME_NAVBAR_DFAULT_TINTCOLOR_OBJ;
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
