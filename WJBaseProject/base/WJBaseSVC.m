//
//  WJBaseSVC.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseSVC.h"
#import "UIImage+Helpers.h"
#import "WJ_MEASURE.h"

@interface WJBaseSVC ()

@end

@implementation WJBaseSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackScrollView];
}

- (void)initBackScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }
}

- (void)setContentSize:(CGSize)contentSize{
    self.scrollView.contentSize = contentSize;
}

- (void)setTitleView:(UIView *)titleView{
    _titleView = titleView;
    self.navigationItem.titleView = titleView;
}

/**
 *  设置scrollView的代理
 *
 *  @param objc scrollView的代理
 */
- (void)setScrollViewDelegateVC:(__autoreleasing id<UIScrollViewDelegate>)objc{
    self.scrollView.delegate = objc;
    if (!_needNavGradiend) {
        return;
    }
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

/**
 *  设置带透明度的导航栏颜色--滑动渐变时使用
 *
 *  @param alpha 导航栏透明度（0~0.99）。不能为1
 */
- (void)setNavaBarColorWithAlpha:(CGFloat)alpha{
    if (!_needNavGradiend) {
        return;
    }
    if (alpha >= 0.99) {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kNavColorWithAlpha(alpha)] forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_needNavGradiend) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat alpha = 0;
        
        CGFloat minAlphaOffset = 64;
        CGFloat maxAlphaOffset = 200;
        if (offsetY) {
            alpha = offsetY/(maxAlphaOffset-minAlphaOffset);
        }
        
        if (alpha > 0) {
            _titleView.hidden = NO;
            if (alpha >= 1) {
                alpha = 0.99;
            }
        } else {
            
            _titleView.hidden = YES;
        }
        _disappearAlpha = alpha;
        _titleView.alpha = alpha;
        
        // 设置导航条的背景图片
        UIImage *image = [UIImage imageWithColor:kNavColorWithAlpha(alpha)];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
}

@end
