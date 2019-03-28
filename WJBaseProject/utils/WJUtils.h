//
//  WJUtils.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJUtils : NSObject

/// 获取当前页面
+ (WJBaseVC *)getCurrentVC;

/// 获取未销毁的指定界面
+ (WJBaseVC *)getCurrVC:(NSString *)className;

+ (void)toast:(NSString *)toastStr;

+ (void)toast:(NSString *)toastStr delay:(CGFloat)delay;

+ (void)showHUDToView:(UIView *)toView;

+ (void)hideHUDFromView:(UIView *)view;

+ (BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
