//
//  UILabel+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UILabel+Helpers.h"
#import "NSObject+Helpers.h"

#define DEFAULT_FONT [UIFont fontWithName:@"PingFang-SC-Regular" size:14]
@implementation UILabel (Helpers)

+(UILabel*)create{
    return [UILabel createWithFont:DEFAULT_FONT];
}

+(UILabel*)createWithFont:(UIFont*)font{
    return [UILabel createWithFont:font textColor:[UIColor blackColor]];
}

+(UILabel*)createWithColor:(UIColor*)color{
    return [UILabel createWithFont:DEFAULT_FONT textColor:color];
}

+(UILabel*)createWithFont:(UIFont *)font textColor:(UIColor*)textColor{
    UILabel *label=[[UILabel alloc]init];
    
    label.font=font;
    
    label.textColor=textColor;
    
    return label;
}
+(UILabel*)createWithFont:(UIFont *)font textColor:(UIColor*)textColor lineNumber:(NSInteger)number{
    UILabel *lbl = [self createWithFont:font textColor:textColor];
    if (number != 1) {
        lbl.numberOfLines = number;
        lbl.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return lbl;
}

+(UILabel *)createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    return label;
}

/// 活动label可变的attributedText
- (NSMutableAttributedString *)getMulAttributedText{
    NSMutableAttributedString *attribute = nil;
    if (self.attributedText.length > 0) {
        attribute = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }else {
        if (self.text == nil) {
            self.text = @"";
        }
        attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
        [attribute addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attribute.length)];
        
        [attribute addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, attribute.length)];
    }
    return attribute;
}

// 设置行间距
- (void)attributeStrWithLineSpace:(CGFloat)lineSpace{
    
    NSMutableAttributedString *attribute = [self getMulAttributedText];
    if (lineSpace != 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = self.textAlignment;
        [paragraphStyle setLineSpacing:lineSpace];//调整行间距
        [attribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attribute.length)];
    }
    
    self.attributedText = attribute;
}

/// 设置下划线
- (void)attributeWithUnderLine{
    NSMutableAttributedString *attribute = [self getMulAttributedText];
    [attribute addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attribute.length)];
    self.attributedText = attribute;
}

/// 设置下划线
- (void)addUnderLineWithRange:(NSRange)range{
    NSMutableAttributedString *attribute = [self getMulAttributedText];
    [attribute addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    self.attributedText = attribute;
}

/**
 自定义字符串的颜色和字体

 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param colors 不同下标对应的颜色，例@[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]]
 @param fonts 不同下标对应的字体l，例@[[UIFont systemFontOfSize:10],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:12]]
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs colors:(NSArray<UIColor *> *_Nullable)colors fonts:(NSArray<UIFont *> *_Nullable)fonts{
    
    if (![NSObject isEmpty:colors]) {
        NSAssert(indexs.count == colors.count, @"下标数组必须与color数组相对应");
    }
    if (![NSObject isEmpty:fonts]) {
        NSAssert(indexs.count == fonts.count, @"下标数组必须与font数组相对应");
    }
    
    NSString *content = [strArray componentsJoinedByString:@""];
    NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc]initWithString:content];
    for (NSInteger i = 0; i<indexs.count; i++) {
        NSArray<NSNumber *> *indexArray = indexs[i];
        UIColor *color = [NSObject isEmpty:colors] ? self.textColor : colors[i];
        UIFont *font = [NSObject isEmpty:fonts] ? self.font : fonts[i];
        for (NSInteger j = 0; j<indexArray.count; j++) {
            NSUInteger index = [indexArray[j] integerValue];
            NSAssert(index<strArray.count, @"下标数组越界，请仔细检查下标数组是否正确");
            NSString *str = strArray[index];
            NSRange range = [content rangeOfString:str];
            if (color != nil) {
                [attrContent addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            if (font != nil) {
                [attrContent addAttribute:NSFontAttributeName value:font range:range];
            }
        }
    }
    self.attributedText = attrContent;
}

/**
 自定义字符串的颜色和字体
 
 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param colors 不同下标对应的颜色，例@[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]]
 @param font 整体字体
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs colors:(NSArray<UIColor *> *)colors font:(UIFont *)font{
    self.font = font;
    [self setAttribute:strArray indexs:indexs colors:colors fonts:nil];
}

/**
 自定义字符串的颜色和字体
 
 @param strArray 不同显示的字符串组成的字符串数组 例@[@"我是",@"一只",@"小",@"小",@"鸟"]
 @param indexs 不同格式的字符串对应的下标数组，例@[@[@0,@2],@[@1,@3].@[@5]]
 @param fonts 不同下标对应的字体l，例@[[UIFont systemFontOfSize:10],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:12]]
 @param color 所有字体的颜色
 */
- (void)setAttribute:(NSArray<NSString *> *)strArray indexs:(NSArray<NSArray <NSNumber *>*> *)indexs fonts:(NSArray<UIFont *> *_Nullable)fonts color:(UIColor *)color{
    self.textColor = color;
    [self setAttribute:strArray indexs:indexs colors:nil fonts:fonts];
}

@end
