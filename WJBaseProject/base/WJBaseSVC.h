//
//  WJBaseSVC.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJBaseSVC : WJBaseVC

@property (nonatomic,strong) UIScrollView *scrollView;

- (void)setContentSize:(CGSize)contentSize;



#pragma mark 导航栏渐变时使用以下属性和方法
@property (nonatomic,strong) UIView *titleView;//导航栏的titleView

@property (nonatomic,assign) CGFloat disappearAlpha;

/**
 *  设置带透明度的导航栏颜色--滑动渐变时使用
 *  @param alpha 导航栏透明度（0~0.99）。不能为1
 */
- (void)setNavaBarColorWithAlpha:(CGFloat)alpha;

/**
 *  设置scrollView的代理
 *  @param objc scrollView的代理
 */
- (void)setScrollViewDelegateVC:(__autoreleasing id<UIScrollViewDelegate>)objc;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
