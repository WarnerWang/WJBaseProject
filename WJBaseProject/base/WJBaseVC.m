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

@end
