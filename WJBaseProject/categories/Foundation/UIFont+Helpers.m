//
//  UIFont+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIFont+Helpers.h"

@implementation UIFont (Helpers)

+ (UIFont *)commonFont:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:fontSize];
}

+ (UIFont *)boldFont:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFang-SC-Semibold" size:fontSize];
}

@end
