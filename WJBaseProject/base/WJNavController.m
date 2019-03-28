//
//  WJNavController.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJNavController.h"

@interface WJNavController ()

@end

@implementation WJNavController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
