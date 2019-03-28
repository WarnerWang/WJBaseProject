//
//  UIViewController+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Helpers.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helpers)

/// 设置导航栏背景颜色
- (void)setNavBarBackColor:(UIColor *)color;

/// 设置导航栏标题颜色和字体
- (void)setNavBarTitleColor:(UIColor *)titleColor font:(UIFont *)font;

/// push到下一界面
-(void)pushNextVC:(NSString*) nextVcName;

-(void)pushNextVCByInstance:(UIViewController *) nextVC;

/// 替换当前界面
-(void) replaceVC:(NSString*) nextVcName;

-(void) replaceVCWithController:(UIViewController*)vc;

/// 返回到上一界面
-(void)popVC;

/// 返回到根页面
-(void)popToRootVC;

-(void)popToVC:(UIViewController*)vc;

/// 返回到指定的控制器，若没有则会返回上一级
- (void)popToStrVC:(NSString *)vc;

/// 返回到指定的控制器，若没有不会返回上一级
- (void)popToDesignatedVC:(NSString *)vc;

/// 返回前index的视图
- (void)popToIndex:(NSInteger)index;

/// 设置返回按钮
- (UIButton *)setLeftBackBtn:(NSString *)imageName;

/// 设置导航栏左按钮--图片
- (UIButton *)setLeftBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block;

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block;

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block;

/// 设置导航栏右按钮--本地图片
- (UIButton *)setRightBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--网络图片
- (UIButton *)setRightBtnWitnImageUrl:(NSString *)imageUrl clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block;

/// 当前navigationController下push的VC
@property (nonatomic,strong,readonly) NSArray* navPushControllers;

/// 当前navigationController下push的VC数量
@property (nonatomic,assign,readonly) NSUInteger navPushCount;

@end

NS_ASSUME_NONNULL_END
