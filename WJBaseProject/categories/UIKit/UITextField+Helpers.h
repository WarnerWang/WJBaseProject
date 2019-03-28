//
//  UITextField+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITextFieldEditInputType) {
    UITextFieldEditInputTypePhone,            //手机号
    UITextFieldEditInputTypeBankCard,         //银行卡
};

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Helpers)

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font;

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor;

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor;

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor keyboardType:(UIKeyboardType)keyboardType;

/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftSize 左视图大小
 */
- (void)setLeftViewWithText:(NSString *)leftText leftSize:(CGSize)leftSize;

/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftSize 左视图大小
 @param leftTextAlignment 文字对齐方式
 */
- (void)setLeftViewWithText:(NSString *)leftText leftSize:(CGSize)leftSize leftTextAlignment:(NSTextAlignment)leftTextAlignment;

/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftFont 字体大小
 @param leftColor 字体颜色
 @param leftSize 左视图大小
 @param leftTextAlignment 文字对齐方式
 */
- (void)setLeftViewWithText:(NSString *)leftText leftFont:(UIFont *)leftFont leftColor:(UIColor *)leftColor leftSize:(CGSize)leftSize leftTextAlignment:(NSTextAlignment)leftTextAlignment;

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder;

- (void)setAttributePlaceholderWithPlaceholderColor:(UIColor *)placeHolderColor;

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder font:(UIFont *)font;

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor;

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor font:(UIFont *)font;

- (void)setVerticalCenterAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor font:(UIFont *)font;

/// 为输入的手机号格式化
- (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string inputType:(UITextFieldEditInputType)inputType;

@end

NS_ASSUME_NONNULL_END
