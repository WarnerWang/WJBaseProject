//
//  UITableView+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UITableView+Helpers.h"

@implementation UITableView (Helpers)

+(UITableView*)createGrouped:(__autoreleasing id<UITableViewDelegate,UITableViewDataSource>)target{
    
    return [self createTable:UITableViewStyleGrouped target:target];
    
}

+(UITableView*)createPlain:(__autoreleasing id<UITableViewDelegate,UITableViewDataSource>)target{
    return [self createTable:UITableViewStylePlain target:target];
}

+(UITableView *)createTable:(UITableViewStyle)style target:(__autoreleasing id<UITableViewDelegate,UITableViewDataSource>)target{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:style];
    
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator=NO;
    tableView.showsHorizontalScrollIndicator=NO;
    
    tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
    tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    
    return tableView;
}

@end
