//
//  UITextField+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UITextField+Helpers.h"
#import "UILabel+Helpers.h"
#import "NSString+Helpers.h"

@implementation UITextField (Helpers)

+ (UITextField *)createTextField:(UIFont *)font textColor:(UIColor *)textColor{
    return [UITextField createTextField:@"" font:font textColor:textColor];
}

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font{
    return [UITextField createTextField:placeHolper font:font textColor:[UIColor whiteColor]];
}

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor{
    return [UITextField createTextField:placeHolper font:font textColor:textColor keyboardType:UIKeyboardTypeDefault];
}

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor{
    UITextField *textField = [UITextField createTextField:placeHolper font:font textColor:textColor];
    [textField setAttributePlaceholderWithPlaceholderColor:placeholderColor];
    return textField;
}

+ (UITextField *)createTextField:(NSString *)placeHolper font:(UIFont *)font textColor:(UIColor *)textColor keyboardType:(UIKeyboardType)keyboardType{
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeHolper;
    textField.font = font;
    textField.textColor = textColor;
    textField.keyboardType = keyboardType;
    textField.backgroundColor = [UIColor clearColor];
    return textField;
}

/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftSize 左视图大小
 */
- (void)setLeftViewWithText:(NSString *)leftText leftSize:(CGSize)leftSize{
    [self setLeftViewWithText:leftText leftSize:leftSize leftTextAlignment:NSTextAlignmentCenter];
}

/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftSize 左视图大小
 @param leftTextAlignment 文字对齐方式
 */
- (void)setLeftViewWithText:(NSString *)leftText leftSize:(CGSize)leftSize leftTextAlignment:(NSTextAlignment)leftTextAlignment{
    [self setLeftViewWithText:leftText leftFont:self.font leftColor:self.textColor leftSize:leftSize leftTextAlignment:leftTextAlignment];
}


/**
 设置textField的文字左视图
 @param leftText 文字内容
 @param leftFont 字体大小
 @param leftColor 字体颜色
 @param leftSize 左视图大小
 @param leftTextAlignment 文字对齐方式
 */
- (void)setLeftViewWithText:(NSString *)leftText leftFont:(UIFont *)leftFont leftColor:(UIColor *)leftColor leftSize:(CGSize)leftSize leftTextAlignment:(NSTextAlignment)leftTextAlignment{
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftSize.width, leftSize.height)];
    UILabel *leftLabel = [UILabel createLabelWithText:leftText font:leftFont textColor:leftColor];
    [leftView addSubview:leftLabel];
    leftLabel.frame = CGRectMake(10, 0, leftSize.width-20, leftSize.height);
    leftLabel.textAlignment = leftTextAlignment;
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder{
    [self setAttributePlaceholderWithText:ploceholder textColor:self.textColor font:self.font];
}

- (void)setAttributePlaceholderWithPlaceholderColor:(UIColor *)placeHolderColor{
    [self setAttributePlaceholderWithText:self.placeholder textColor:placeHolderColor font:self.font];
}

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder font:(UIFont *)font{
    [self setAttributePlaceholderWithText:ploceholder textColor:self.textColor font:font];
}

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor{
    [self setAttributePlaceholderWithText:ploceholder textColor:textColor font:self.font];
}

- (void)setAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor font:(UIFont *)font{
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:ploceholder attributes:@{NSForegroundColorAttributeName:textColor,NSFontAttributeName:font}];
}


- (void)setVerticalCenterAttributePlaceholderWithText:(NSString *)ploceholder textColor:(UIColor *)textColor font:(UIFont *)font{
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = self.font.lineHeight - (self.font.lineHeight - font.lineHeight) / 2.0;
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:ploceholder attributes:@{NSForegroundColorAttributeName:textColor,NSFontAttributeName:font,NSParagraphStyleAttributeName : style}];
}


- (void)layoutPlaceholderCenter{
    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    UIFont *placeholderFont = [self.defaultTextAttributes[NSFontAttributeName] mutableCopy];
    style.minimumLineHeight = self.font.lineHeight - (self.font.lineHeight - placeholderFont.lineHeight) / 2.0;
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Placeholder text"attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:79/255.0f green:79/255.0f blue:79/255.0f alpha:0.5f],NSFontAttributeName : [UIFont fontWithName:@"Gotham-BookItalic" size:14.0],NSParagraphStyleAttributeName : style}];
}

- (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string inputType:(UITextFieldEditInputType)inputType{
    
    NSString *text = textField.text;
    if ([string isEqualToString:@""]) {//删除
        
        if (range.length == 1) {//删除一位
            
            if (range.location == text.length - 1) {// 最后一位，遇到空格多删除一位
                if ([text characterAtIndex:text.length - 1] == ' ') {
                    [textField deleteBackward];
                }
                return YES;
            }else {//从中间删除
                NSInteger offset = range.location;
                
                if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                    [textField deleteBackward];
                    offset--;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text inputType:inputType];
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                return NO;
            }
        }else if (range.length > 0) {//删除多位
            BOOL isLast = NO;
            //如果是从最后一位开始
            if (range.location + range.length == textField.text.length) {
                isLast = YES;
            }
            [textField deleteBackward];
            textField.text = [self parseString:textField.text inputType:inputType];
            
            NSInteger offset = range.location;
            if ([textField.text characterAtIndex:range.location] == ' ') {
                offset++;
            }
            
            if (isLast) {
                //光标在最后一位了
            }else {
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            }
            
            return NO;
        }else {
            return YES;
        }
    }else if (string.length > 0) {
        
        NSInteger textLength = 11;
        if (inputType == UITextFieldEditInputTypePhone) {
            textLength = 11;
        }else if (inputType == UITextFieldEditInputTypeBankCard) {
            textLength = 19;
        }
        
        // 限制输入字符个数
        if ([textField.text noneSpaseString].length + string.length - range.length > textLength) {
            return NO;
        }
        /// 判断是否属纯数字
        if (![NSString isPureInt:string]) {
            return NO;
        }
        [textField insertText:string];
        textField.text = [self parseString:textField.text inputType:inputType];
        
        NSInteger offset = range.location + string.length;
        if ([textField.text characterAtIndex:range.location] == ' ') {
            offset++;
        }
        UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
        textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
        return NO;
    }
    
    return YES;
}

- (NSString*)parseString:(NSString*)string inputType:(UITextFieldEditInputType)inputType{
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string noneSpaseString]];
    switch (inputType) {
        case UITextFieldEditInputTypePhone:{
            if (mStr.length >3) {
                [mStr insertString:@" " atIndex:3];
            }if (mStr.length > 8) {
                [mStr insertString:@" " atIndex:8];
                
            }
        }
            break;
        case UITextFieldEditInputTypeBankCard:{
            for (NSInteger i = 4, j = 0; i+j<mStr.length; i+=4, j++) {
                [mStr insertString:@" " atIndex:i+j];
            }
        }
            break;
        default:
            break;
    }
    
    
    return  mStr;
}

@end
