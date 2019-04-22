//
//  WJBaseVC.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Helpers.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJBaseVC : UIViewController

@property (nonatomic,assign) BOOL navigationBarHidden;

// 返回按钮的点击--若要做特殊操作只需重写此方法
- (void)backBtnClicked:(UIButton *)sender;

- (void)setLeftBackBtn:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
