//
//  UIScreen+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIScreen+Helpers.h"

@implementation UIScreen (Helpers)

+ (CGSize)screenSize{
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [[UIScreen mainScreen] bounds].size;
    });
    return size;
}

+ (BOOL)isPortrait{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }else{
        return NO;
    }
}

+ (CGFloat)screenWidth{
    CGSize size = [self screenSize];
    if (![self isPortrait]) {
        return size.height;
    }
    return size.width;
}

+ (CGFloat)screenHeight{
    CGSize size = [self screenSize];
    if (![self isPortrait]) {
        return size.width;
    }
    return size.height;
}

+ (CGFloat)screenScale {
    static CGFloat screenScale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    return screenScale;
}

/// 状态栏高度
+ (CGFloat)statusBarHeight{
    static CGFloat height = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        height = [UIApplication sharedApplication].statusBarFrame.size.height;
    });
    return height;
}

/// 是否是全面屏手机
+ (BOOL)isFullScheenPhone{
    CGFloat statusBarheight = [self statusBarHeight];
    if (statusBarheight != 20) {
        return YES;
    }else{
        return NO;
    }
}

/// 底部安全区域高度
+ (CGFloat)bottomSafeAreaHeight{
    static CGFloat height = 0;
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            height = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
        });
    }
    return height;
}

@end
