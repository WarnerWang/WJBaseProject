//
//  UIViewController+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIViewController+Helpers.h"
#import "NSString+Helpers.h"
#import "UIColor+Helpers.h"
#import "NSString+Helpers.h"
#import "UIImageView+Helpers.h"
#import "UIFont+Helpers.h"

@implementation UIViewController (Helpers)

/// 设置导航栏背景颜色
- (void)setNavBarBackColor:(UIColor *)color{
    self.navigationController.navigationBar.barTintColor = color;
}

/// 设置导航栏标题颜色和字体
- (void)setNavBarTitleColor:(UIColor *)titleColor font:(UIFont *)font{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:titleColor}];
}

-(void)pushNextVC:(NSString*) nextVcName{
    if(nextVcName == nil || [@"" isEqualToString:nextVcName]){
        
        return;
    }
    
    UIViewController *vc = [[NSClassFromString(nextVcName) alloc] init];
    [self pushNextVCByInstance:vc];
}

-(void)pushNextVCByInstance:(UIViewController *) nextVC{
    if (![self shouldPushToNextVC:nextVC]) {
        return;
    }
    nextVC.hidesBottomBarWhenPushed = YES;
    [self pushNextVCByInstance:nextVC animation:YES];
}

- (BOOL)shouldPushToNextVC:(UIViewController *)nextVC{
    
    return YES;
}

-(void)pushNextVCByInstance:(UIViewController *) nextVC animation:(BOOL)animation{
    
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:animation];
}

-(void) replaceVC:(NSString*) nextVcName{
    
    if ([NSString isEmpty:nextVcName]) {
        return;
    }
    
    UIViewController *vc=[[NSClassFromString(nextVcName) alloc]init];
    
    [self replaceVCWithController:vc];
    
}

-(void) replaceVCWithController:(UIViewController*)vc{
    
    if (!vc) {
        return;
    }
    
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController *currNavVC=self.navigationController;

    [currNavVC popVC];

    [currNavVC pushNextVCByInstance:vc animation:NO];
    
    
}

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToRootVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popToVC:(UIViewController*)vc{
    if (vc==nil) {
        return;
    }
    [self.navigationController popToViewController:vc animated:YES];
}

/// 返回到指定的控制器，若没有则会返回上一级
- (void)popToStrVC:(NSString *)vc{
    for (UIViewController *subvc in self.navPushControllers) {
        if ([NSStringFromClass([subvc class]) isEqualToString:vc]) {
            
            [self popToVC:subvc];
            return;
        }
    }
    [self popVC];
}

/// 返回到指定的控制器，若没有不会返回上一级
- (void)popToDesignatedVC:(NSString *)vc{
    for (UIViewController *subvc in self.navPushControllers) {
        if ([NSStringFromClass([subvc class]) isEqualToString:vc]) {
            
            [self popToVC:subvc];
            return;
        }
    }
}

/// 返回前index的视图
- (void)popToIndex:(NSInteger)index{
    for (NSInteger i = self.navPushCount -1 , j = 0; i>=0 ; i--, j++) {
        if (j == index) {
            UIViewController *subvc = self.navPushControllers[i];
            [self popToVC:subvc];
            return;
        }
    }
}

/// 设置返回按钮
- (UIButton *)setLeftBackBtn:(NSString *)imageName{
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [self setLeftBtnWithImageName:imageName clickAction:^(UIButton * _Nonnull sender) {
        [weakSelf popVC];
    }];
    return backBtn;
}

/// 设置导航栏左按钮--图片
- (UIButton *)setLeftBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block{
    UIButton *backBtn = [UIButton createWithImageName:imageName];
    backBtn.frame = CGRectMake(0, 0, 40, 30);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem *nativeItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    self.navigationItem.leftBarButtonItem = nativeItem;
    
    [backBtn addClick:block];
    return backBtn;
}

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block{
    return [self setLeftBtnWithTitle:title titleColor:RGBHEX(0xffffff) titleFont:FONT_COMMON(14) clickAction:block];
}

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block{
    UIButton *backBtn = [UIButton createBtnWithText:title textColor:titleColor textFont:titleFont];
    CGFloat width = [title widthForFont:backBtn.titleLabel.font];
    backBtn.frame = CGRectMake(0, 0, width+10, 40);
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backBtn addClick:block];
    UIBarButtonItem *nativeItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = nativeItem;
    
    return backBtn;
}

/// 设置导航栏右按钮--本地图片
- (UIButton *)setRightBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block{
    UIButton *btn = [UIButton createWithImageName:imageName];
    btn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addClick:block];
    self.navigationItem.rightBarButtonItem = barBtn;
    return btn;
}

/// 设置导航栏有按钮--网络图片
- (UIButton *)setRightBtnWitnImageUrl:(NSString *)imageUrl clickAction:(BtnClickBlock)block{
    UIButton *btn = [UIButton create];
    btn.frame = CGRectMake(0, 0, 40, 40);
    __weak typeof(btn) weakBtn = btn;
    [btn.imageView setImageWithUrlStr:imageUrl complete:^UIImage *(UIImage *image) {
        [weakBtn setImage:image forState:UIControlStateNormal];
        return image;
    }];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addClick:block];
    self.navigationItem.rightBarButtonItem = barBtn;
    return btn;
}

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block{
    return [self setRightBtnWithTitle:title titleColor:RGBHEX(0xffffff) titleFont:FONT_COMMON(14) clickAction:block];
}

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block{
    UIButton *btn = [UIButton createBtnWithText:title textColor:titleColor textFont:titleFont];
    CGFloat width = [title widthForFont:btn.titleLabel.font];
    btn.frame = CGRectMake(0, 0, width+10, 40);
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addClick:block];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    return btn;
}

/// 当前navigationController下push的VC
- (NSArray *)navPushControllers{
    return self.navigationController.viewControllers;
}

/// 获取当前navigationController下push的VC数量
- (NSUInteger)navPushCount{
    return self.navPushControllers.count;
}

@end
