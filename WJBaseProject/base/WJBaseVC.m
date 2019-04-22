//
//  WJBaseVC.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseVC.h"
#import "WJ_MEASURE.h"
#import "UIColor+Helpers.h"
#import "UIFont+Helpers.h"
#import "UIDevice+Helpers.h"
#import "WJWebVC.h"

@interface WJBaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation WJBaseVC

// 设置到导航栏
- (void)loadView{
    [super loadView];
    if (!kiOS11Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self setupNavConfig];
    self.view.backgroundColor = RGBHEX(0xf4f4f4);
}

- (void)setupNavConfig{
    [self setNavBarBackColor:kNavColorWithAlpha(1)];
    [self setNavBarTitleColor:RGBHEX(0x3d3d3d) font:FONT_BOLD(17)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = NO;
    [self setLeftBackBtn:@"icon_fanhui"];
    self.view.backgroundColor = [UIColor randomColor];
//    [self setRightBtnWithTitle:@"网页" clickAction:^(UIButton * _Nonnull sender) {
//        WJWebVC *webVC = [[WJWebVC alloc]init];
//        webVC.changeTitle = YES;
//        [webVC addWebView:@"https://www.baidu.com"];
//        [self pushNextVCByInstance:webVC];
//    }];
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    if (self.navigationController.navigationBarHidden == navigationBarHidden) {
        return;
    }
    self.navigationController.navigationBarHidden = navigationBarHidden;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)setLeftBackBtn:(NSString *)imageName{
    typeof(self) weakself = self;
    [self setLeftBtnWithImageName:imageName clickAction:^(UIButton * _Nonnull sender) {
        [weakself backBtnClicked:sender];
    }];
}

// 返回按钮的点击
- (void)backBtnClicked:(UIButton *)sender{
    [self popVC];
}

@end
