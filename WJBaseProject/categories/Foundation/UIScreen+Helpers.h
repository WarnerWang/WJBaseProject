//
//  UIScreen+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScheenWidth [UIScreen screenWidth]
#define kScheenHeight [UIScreen screenHeight]
/// 是否是全面屏手机
#define kIsFullScreen [UIScreen isFullScheenPhone]
/// 状态栏高度
#define kNotificationHeight [UIScreen statusBarHeight]
/// 底部安全区域高度
#define kBtmSafeareaHeight [UIScreen bottomSafeAreaHeight]

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (Helpers)

/// 屏幕尺寸
+ (CGSize)screenSize;

/// 是否是竖屏
+ (BOOL)isPortrait;

/// 屏幕宽度
+ (CGFloat)screenWidth;

/// 屏幕高度
+ (CGFloat)screenHeight;

/// 缩放系数
+ (CGFloat)screenScale;

/// 状态栏高度
+ (CGFloat)statusBarHeight;

/// 是否是全面屏手机
+ (BOOL)isFullScheenPhone;

/// 底部安全区域高度
+ (CGFloat)bottomSafeAreaHeight;

@end

NS_ASSUME_NONNULL_END
