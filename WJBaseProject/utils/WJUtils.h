//
//  WJUtils.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJBaseVC.h"
#import "WJMainTabBarVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJUtils : NSObject

/// 获取当前ViewController页面
+ (WJBaseVC *)getCurrentVC;

/// 获取未销毁的指定界面
+ (WJBaseVC *)getCurrVC:(NSString *)className;

/// 获取rootVC
+ (WJMainTabBarVC *)getRootVC;

+ (void)toast:(NSString *)toastStr;

+ (void)toast:(NSString *)toastStr delay:(CGFloat)delay;

/// 在toView上显示loading框
+ (void)showHUDToView:(UIView *)toView;

/// 移除view上的loading框
+ (void)hideHUDFromView:(UIView *)view;

+ (BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
