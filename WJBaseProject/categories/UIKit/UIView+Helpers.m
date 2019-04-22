//
//  UIView+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIView+Helpers.h"
#import "NSObject+Helpers.h"

@implementation UIView (Helpers)

+(UIView*)createWithBackgroundColor:(UIColor*)color{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=color;
    return view;
}

- (void)addMaskViewWithAlpha:(CGFloat)alpha{
    [self layoutIfNeeded];
    UIView *view=[UIView createWithBackgroundColor:[UIColor colorWithWhite:0 alpha:alpha]];
    view.frame = self.bounds;
    [self addSubview:view];
    
}

- (void)addLineWithDirection:(LineDirection)direction Color:(UIColor *)color Width:(CGFloat)width{
    
    UIView *line = [UIView new];
    line.backgroundColor = color;
    [self addSubview:line];
    if (direction & LineDirectionTop) {
        line.frame = CGRectMake(0, 0, self.width, width);
    }
    
    if (direction & LineDirectionBottom) {
        line.frame = CGRectMake(0, self.height-width, self.width, width);
    }
    
    if (direction & LineDirectionLeft) {
        line.frame = CGRectMake(0, 0, width, self.height);
    }
    
    if (direction & LineDirectionRight) {
        line.frame = CGRectMake(0, self.width-width, width, self.height);
    }
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

// 设置圆角
- (void)setCornerWithRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

// 设置圆角及边框
- (void)setCornerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self setCornerWithRadius:radius];
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

/// 设置部分圆角
- (void)setCorners:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornewRadii{
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornewRadii, cornewRadii)];
    CAShapeLayer *maskLayout = [[CAShapeLayer alloc]init];
    maskLayout.frame = self.bounds;
    maskLayout.path = maskPath.CGPath;
    self.layer.mask = maskLayout;
}

/**
 为视图添加从左到右的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)]];
}


/**
 为视图添加从左到右的带圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius{
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)] cornerRadius:cornerRadius];
}


/**
 为视图添加从左到右的带部分圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii{
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)] rectCorners:rectCorners cornerRadii:cornewRadii];
}


/**
 为视图添加从左到右的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations{
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


/**
 为视图添加从左到右带圆角的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations cornerRadius:(CGFloat)cornerRadius{
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = cornerRadius;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


/**
 为视图添加从左到右带圆角的渐变色
 
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii{
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(cornewRadii, cornewRadii)];
    CAShapeLayer *maskLayout = [[CAShapeLayer alloc]init];
    maskLayout.frame = self.bounds;
    maskLayout.path = maskPath.CGPath;
    gradientLayer.mask = maskLayout;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)viewController {
    UIResponder *responder = (UIResponder *)self;
    while (responder == [responder nextResponder]) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

+ (void)hideKeyBoard {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        for (UIView *view in window.subviews) {
            [view dismissAllKeyBoard];
        }
    }
}

- (BOOL)dismissAllKeyBoard{
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView dismissAllKeyBoard]) {
            return YES;
        }
    }
    return NO;
}

- (void)addTapWithBlock:(TapBlock)block{
    SEL sel = @selector(tapAction:);
    if (block) {
        [self setAssociateValue:block withKey:sel];
    }
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:sel];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapG];
}

- (void)tapAction:(UIView *)sender{
    TapBlock block = [self getAssociatedValueForKey:_cmd];
    if (block) {
        block(sender);
    }
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
