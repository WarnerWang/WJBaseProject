//
//  UIButton+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIButton+Helpers.h"
#import "NSObject+Helpers.h"

#define highlightedAlpha 0.6
@implementation UIButton (Helpers)

+(UIButton*)create{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    return button;
}

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName{
    UIButton *button=[UIButton create];
    [button setBackgroundImage:[UIImage imageNamed:bgName] forState:UIControlStateNormal];
    
    return button;
}

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName title:(NSString*)title{
    UIButton *button=[UIButton createWithBackgroundImageName:bgName];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
}

+(UIButton*)createWithBackgroundImageName:(NSString*)bgName title:(NSString*)title titleColor:(UIColor*)titleColor{
    UIButton *button=[UIButton createWithBackgroundImageName:bgName title:title];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

+(UIButton*)createWithImageName:(NSString*)imageName{
    UIButton *button=[UIButton create];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return button;
    
}

+ (UIButton *)createWithImageName:(NSString *)imageName title:(NSString *)title titleFont:(UIFont*)font titleColor:(UIColor*)titleColor{
    UIButton *btn = [UIButton createBtnWithText:title textColor:titleColor textFont:font];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

+(UIButton*)createFillBtnWithNormalText:(NSString*)text titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor{
    
    return [UIButton createFillBtnWithNormalText:text titleColor:titleColor backgroundColor:backgroundColor font:[UIFont systemFontOfSize:17]];
    
}

+(UIButton*)createFillBtnWithNormalText:(NSString*)text titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor font:(UIFont *)font{
    UIButton *button=[UIButton create];
    
    [button setTitle:text forState:UIControlStateNormal];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    [button setTitleColor:[titleColor colorWithAlphaComponent:highlightedAlpha] forState:UIControlStateHighlighted];
    
    [button setBackgroundColor:backgroundColor];
    
    button.titleLabel.font = font;
    
    return button;
}

+(UIButton*)createRectWithBorderColor:(UIColor*)borderColor title:(NSString*)title{
    UIButton *button=[UIButton create];
    
    button.layer.masksToBounds=YES;
    button.layer.borderWidth=0.5;
    button.layer.borderColor=borderColor.CGColor;
    button.layer.cornerRadius=5;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
    
}

+(UIButton*)createRectWithBorderColor:(UIColor*)borderColor title:(NSString*)title titleFont:(UIFont*)font titleColor:(UIColor*)titleColor{
    UIButton *btn=[UIButton createRectWithBorderColor:borderColor title:title];
    
    btn.titleLabel.font=font;
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:[titleColor colorWithAlphaComponent:highlightedAlpha] forState:UIControlStateHighlighted];
    
    return btn;
}

+ (UIButton *)createBtnWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    UIButton *btn = [UIButton create];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}

+ (UIButton *)createBtnWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitleColor:[textColor colorWithAlphaComponent:highlightedAlpha] forState:UIControlStateHighlighted];
    btn.titleLabel.font = textFont;
    return btn;
}

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
    
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    CGFloat labelHeight = self.titleLabel.frame.size.height;
    
    CGFloat imageInsetsTop = 0.0f;
    CGFloat imageInsetsLeft = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight = 0.0f;
    
    CGFloat titleInsetsTop = 0.0f;
    CGFloat titleInsetsLeft = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight = 0.0f;
    
    switch (style) {
        case ButtonEdgeInsetsStyleImageRight:
        {
            space = space * 0.5;
            
            imageInsetsLeft = labelWidth + space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = - (imageViewWidth + space);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case ButtonEdgeInsetsStyleImageLeft:
        {
            space = space * 0.5;
            
            imageInsetsLeft = -space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = space;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
        case ButtonEdgeInsetsStyleImageBottom:
        {
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5 - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
            
        }
            break;
        case ButtonEdgeInsetsStyleImageTop:
        {
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5 - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}

- (void)addClick:(BtnClickBlock)block{
    [self addClick:UIControlEventTouchUpInside block:block];
}

- (void)addClick:(UIControlEvents)eventType block:(BtnClickBlock)block{
    SEL sel = @selector(btnClickAction:);
    if (block) {
        [self setAssociateValue:block withKey:sel];
    }
    [self addTarget:self action:sel forControlEvents:eventType];
}

- (void)btnClickAction:(UIButton *)sender{
    BtnClickBlock block = [self getAssociatedValueForKey:_cmd];
    if (block) {
        block(sender);
    }
}

@end
