//
//  UIFont+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FONT_COMMON(fontSize) [UIFont commonFont:(fontSize)]
#define FONT_BOLD(fontSize) [UIFont boldFont:(fontSize)]

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Helpers)

+ (UIFont *)commonFont:(CGFloat)fontSize;

+ (UIFont *)boldFont:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
