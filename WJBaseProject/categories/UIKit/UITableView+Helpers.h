//
//  UITableView+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Helpers)

+(UITableView*)createGrouped:(__autoreleasing id<UITableViewDelegate,UITableViewDataSource>)target;

+(UITableView*)createPlain:(__autoreleasing id<UITableViewDelegate,UITableViewDataSource>)target;

@end

NS_ASSUME_NONNULL_END
