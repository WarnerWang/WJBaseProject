//
//  WJMainTabBarVC.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJMainTabBarVC.h"
#import "WJNavController.h"
#import "UIColor+Helpers.h"

@interface WJMainTabBarVC ()

@end

@implementation WJMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
}


-(void)setupTabBar{
    
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    
    //首页
    [dataArray addObject:@[@"首页",@"tab_icon_House_normal",@"tab_icon_House_selected",@"WJBaseVC"]];
    
    //比赛
    [dataArray addObject:@[@"功能",@"tab_icon_Date_normal",@"tab_icon_Date_selected",@"WJBaseVC"]];
    
    //我的
    [dataArray addObject:@[@"我的",@"tab_icon_User_normal",@"tab_icon_User_selected",@"WJBaseVC"]];
    
    NSMutableArray *controllers=[[NSMutableArray alloc]init];
    
    for (NSArray * modelArray in dataArray ) {
        if (modelArray.count !=4) {
            
            NSLog(@"tabBar VC info error:%@",modelArray);
            
            continue;
        }
        
        NSString* vcName = modelArray[3];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = modelArray[0];
        [vc.tabBarItem setImage:[[UIImage imageNamed:modelArray[1]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:modelArray[2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [vc.tabBarItem setTitle:modelArray[0]];
        
        [vc.tabBarItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:RGBHEX(0xc0c0c0),NSForegroundColorAttributeName,[UIFont systemFontOfSize:11],NSFontAttributeName,nil] forState:UIControlStateNormal];
        
        [vc.tabBarItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:RGBHEX(0xf5a623),NSForegroundColorAttributeName,[UIFont systemFontOfSize:11],NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        WJNavController *navC=[[WJNavController alloc]initWithRootViewController:vc];
        
        [controllers addObject:navC];
        
    }
    
    self.viewControllers=controllers;
    //    self.delegate = self;
}

@end
