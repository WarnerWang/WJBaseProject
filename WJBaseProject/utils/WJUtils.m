//
//  WJUtils.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJUtils.h"
#import "WJNavController.h"
#import "NSString+Helpers.h"
#import "AppDelegate.h"
#import "WJMainTabBarVC.h"
#import "MBProgressHUD.h"
#import "WJ_MEASURE.h"
#import "WJDataHelper.h"

@implementation WJUtils

/// 获取当前页面
+ (WJBaseVC *)getCurrentVC {
    
    WJNavController *navController = [self getRootNavVC];
    
    WJBaseVC *vc = (WJBaseVC *) [navController.viewControllers lastObject];
    
    return vc;
    
}

/// 获取未销毁的指定界面
+ (WJBaseVC *)getCurrVC:(NSString *)className {
    
    if ([NSString isEmpty:className]) {
        return nil;
    }
    
    WJNavController *navVC = [self getRootNavVC];
    
    if (navVC == nil || navVC.viewControllers.count == 0) {
        return nil;
    }
    
    for (UIViewController *vc in navVC.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            
            return (WJBaseVC *) vc;
        }
    }
    
    return nil;
    
}

+ (WJMainTabBarVC *)getRootVC {
    
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    UIWindow *window = app.window;
    
    WJMainTabBarVC *mainTabBarVC = (WJMainTabBarVC *) window.rootViewController;
    
    return mainTabBarVC;
    
}

/// 获得以BCNavController为跟视图的当前VC
+ (WJBaseVC *)getCurrentVCWithNavRoot{
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    UIViewController *rootVC = app.window.rootViewController;
    if ([rootVC isKindOfClass:[WJNavController class]]) {
        WJNavController *navRootVC = (WJNavController *)rootVC;
        WJBaseVC *vc = (WJBaseVC *) [navRootVC.viewControllers lastObject];
        return vc;
    }else {
        WJMainTabBarVC *mainTabBarVC = (WJMainTabBarVC *)rootVC;
        WJNavController *navRootVC = (WJNavController *)mainTabBarVC.viewControllers[mainTabBarVC.selectedIndex];
        WJBaseVC *vc = (WJBaseVC *) [navRootVC.viewControllers lastObject];
        return vc;
    }
}

+ (WJNavController *)getRootNavVC {
    
    WJMainTabBarVC *mainTabBarVC = (WJMainTabBarVC *) [self getRootVC];
    
    WJNavController *navController = mainTabBarVC.viewControllers[mainTabBarVC.selectedIndex];
    
    return navController;
}

+ (void)toast:(NSString *)toastStr {
    
    [self toast:toastStr delay:2];
}

+ (void)toast:(NSString *)toastStr delay:(CGFloat)delay{
    
    if ([NSString isEmpty:toastStr]) {
        return;
    }
    if ([toastStr isEqualToString:@"操作太频繁"]) {
        return;
    }
    //只显示文字
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:kScreenWindow];
    [kScreenWindow addSubview:hud];
    hud.label.text = toastStr;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.margin = 15;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    CGFloat yOffset = (kScheenHeight - kBtmSafeareaHeight)/2 - kBtmSafeareaHeight - kTabbarHeight - 40;
    hud.offset = CGPointMake(hud.offset.x, yOffset);
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showHUDToView:(UIView *)toView {
    
    [MBProgressHUD showHUDAddedTo:toView animated:YES];
    
}

+ (void)hideHUDFromView:(UIView *)view {
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (BOOL)isLogin{
    return [WJDataHelper getUserInfo] ? YES:NO;
}

+ (void)logout{
    [WJDataHelper saveUserInfo:nil];
    //TODO:跳转到登录页面
}

@end
