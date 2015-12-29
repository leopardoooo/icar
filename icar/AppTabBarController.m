//
//  AppTabBarController.m
//  icar
//
//  Created by Killer on 15/11/3.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "AppTabBarController.h"
#import "MacroDefine.h"

@interface AppTabBarController ()

@end

@implementation AppTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *normalNames = @[@"icon_tabbar_homepage",@"icon_tabbar_merchant_normal",@"icon_tabbar_misc",@"icon_tabbar_onsite",@"icon_tabbar_mine"];
    NSArray *selectedNames = @[@"icon_tabbar_homepage_selected",@"icon_tabbar_merchant_selected",@"icon_tabbar_misc_selected",@"icon_tabbar_onsite_selected",@"icon_tabbar_mine_selected"];
    
    NSDictionary *normalAttrs = [[NSDictionary alloc] initWithObjectsAndKeys:THEME_COLOR_NORMAL_OBJ,NSForegroundColorAttributeName,nil];
    NSDictionary *highlightedAttrs = [[NSDictionary alloc] initWithObjectsAndKeys:THEME_COLOR_HIGHLIGHTED_OBJ,NSForegroundColorAttributeName,nil];
    for(int i = 0; i < self.tabBar.items.count; i++){
        UITabBarItem *barItem = self.tabBar.items[i];
        
        barItem.image = [[UIImage imageNamed:normalNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        barItem.selectedImage = [[UIImage imageNamed:selectedNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [barItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:highlightedAttrs forState:UIControlStateHighlighted];
    }
//    self.tabBar.tintColor = THEME_COLOR_HIGHLIGHTED_OBJ;
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
