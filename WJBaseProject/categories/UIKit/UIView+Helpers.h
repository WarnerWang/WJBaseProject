//
//  UIView+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LineDirection){
    LineDirectionTop = 1 << 1,
    LineDirectionBottom = 1 << 2,
    LineDirectionLeft = 1 << 3,
    LineDirectionRight = 1 << 4
};

typedef void (^TapBlock)(UIView *sender);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Helpers)

+(UIView*)createWithBackgroundColor:(UIColor*)color;

/// 增加遮罩 alpha为遮罩透明度
- (void)addMaskViewWithAlpha:(CGFloat)alpha;

/// 添加边界线
- (void)addLineWithDirection:(LineDirection)direction Color:(UIColor *)color Width:(CGFloat)width;


/**
 添加阴影

 @param color 阴影颜色
 @param offset 阴影偏移量
 @param radius 阴影圆角
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

// 设置圆角
- (void)setCornerWithRadius:(CGFloat)radius;

// 设置圆角及边框
- (void)setCornerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/// 设置部分圆角
- (void)setCorners:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornewRadii;

/**
 为视图添加从左到右的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/**
 为视图添加从左到右的带圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;

/**
 为视图添加从左到右的带部分圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii;

/**
 为视图添加从左到右的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations;

/**
 为视图添加从左到右带圆角的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations cornerRadius:(CGFloat)cornerRadius;

/**
 为视图添加从左到右带圆角的渐变色
 
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii;

- (void)removeAllSubviews;

/// 取消所有页面的第一响应者
+ (void)hideKeyBoard;

/// 取消当前视图下的所有第一响应者
- (BOOL)dismissAllKeyBoard;

/// 获取本视图所在的VC
- (UIViewController *)viewController;

/// 添加视图tap回调事件
- (void)addTapWithBlock:(TapBlock)block;

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@end

NS_ASSUME_NONNULL_END
