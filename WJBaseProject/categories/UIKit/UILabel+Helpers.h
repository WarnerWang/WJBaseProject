//
//  UILabel+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Helpers)

+(UILabel*)create;

+(UILabel*)createWithFont:(UIFont*)font;

+(UILabel*)createWithColor:(UIColor*)color;

+(UILabel*)createWithFont:(UIFont *)font textColor:(UIColor*)textColor;

+(UILabel*)createWithFont:(UIFont *)font textColor:(UIColor*)textColor lineNumber:(NSInteger)number;

+(UILabel *)createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

/// 设置行间距
- (void)attributeStrWithLineSpace:(CGFloat)lineSpace;

/// 设置下划线
- (void)attributeWithUnderLine;

/// 设置下划线
- (void)addUnderLineWithRange:(NSRange)range;

/**
 自定义字符串的颜色和字体
 
 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param colors 不同下标对应的颜色，例@[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]]
                为空则整体使用self.textColor
 @param fonts 不同下标对应的字体l，例@[[UIFont systemFontOfSize:10],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:12]]
                为空则整体使用self.font
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs colors:( NSArray<UIColor *> * _Nullable )colors fonts:( NSArray<UIFont *> * _Nullable )fonts;

/**
 自定义字符串的颜色和字体
 
 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param colors 不同下标对应的颜色，例@[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]]
 @param font 整体字体
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs colors:(NSArray<UIColor *> *)colors font:(UIFont *)font;

/**
 自定义字符串的颜色和字体
 
 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param fonts 不同下标对应的字体l，例@[[UIFont systemFontOfSize:10],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:12]]
 @param color 所有字体的颜色
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs fonts:(NSArray<UIFont *> *_Nullable)fonts color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
