//
//  UIColor+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HUEACOLOR(h,s,b,a) [UIColor colorWithHue:(h)/360.0 saturation:(s)*0.01 brightness:(b)*0.01 alpha:(a)]
#define RGBAGRAY(rgb,a)    RGBACOLOR((rgb),(rgb),(rgb),(a))

#define RGBHEX(rgb) [UIColor UIColorFromHex:(rgb)]
#define RGBAHEX(rgb,a) [UIColor UIColorFromHex:(rgb) alpha:(a)]

@interface UIColor (Helpers)

//[UIColor UIColorFromRGBAColorWithRed:10 green:20 blue:30 alpha:0.8]
+(UIColor *)UIColorFromRGBColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
+(UIColor *)UIColorFromRGBAColorWithRed: (CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

//[UIColor UIColorFromHex:0xc5c5c5 alpha:0.8];
+(UIColor *)UIColorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha;
+(UIColor *)UIColorFromHex:(NSUInteger)rgb;

/// 随机颜色
+(UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
