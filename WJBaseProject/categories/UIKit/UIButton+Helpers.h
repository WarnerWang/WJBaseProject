//
//  UIButton+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

typedef void (^BtnClickBlock)(UIButton *sender);

@interface UIButton (Helpers)

+(UIButton*)create;

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName;

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName title:(NSString*)title;

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName title:(NSString*)title titleColor:(UIColor*)titleColor;

+(UIButton*)createWithImageName:(NSString*)imageName;

+(UIButton*)createFillBtnWithNormalText:(NSString*)text titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor;

+(UIButton*)createFillBtnWithNormalText:(NSString*)text titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor font:(UIFont *)font;

+(UIButton*)createRectWithBorderColor:(UIColor*)borderColor title:(NSString*)title;

+(UIButton*)createRectWithBorderColor:(UIColor*)borderColor title:(NSString*)title titleFont:(UIFont*)font titleColor:(UIColor*)titleColor;

+ (UIButton *)createBtnWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage;

+ (UIButton *)createBtnWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont;

+ (UIButton *)createWithImageName:(NSString *)imageName title:(NSString *)title titleFont:(UIFont*)font titleColor:(UIColor*)titleColor;


/**
 图文混排按钮

 @param style 图片方向
 @param space 图文间隔
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

/// 增加block点击回调事件
- (void)addClick:(BtnClickBlock)block;

/// 增加block点击回调事件
- (void)addClick:(UIControlEvents)eventType block:(BtnClickBlock)block;

@end

NS_ASSUME_NONNULL_END
