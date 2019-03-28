//
//  UIScrollView+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Helpers)

+ (UIScrollView *)create;

- (void)scrollToTop;

- (void)scrollToBottom;

- (void)scrollToLeft;

- (void)scrollToRight;

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (void)scrollToLeftAnimated:(BOOL)animated;

- (void)scrollToRightAnimated:(BOOL)animated;

// 自定义下拉刷新
- (void)addCustomRefreshHeader:(void (^)(void))headerBlock;

/**
 * 下拉刷新
 */
- (void)addRefreshHeader:(void (^)(void))headerBlock;

/**
 * 下拉刷新
 * @param isBeginRefresh 是否在刚进来是就刷新
 */
- (void)addRefreshHeader:(void (^)(void))headerBlock isBeginRefresh:(BOOL)isBeginRefresh;

///开始刷新
- (void)beginRefreshing;

/// 移除下拉刷新
- (void)removeRefreshHeader;

/**
 * 上拉加载更多
 */
- (void)addRefreshFooter:(void (^)(void))footerBlock;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;

/// 重置没有更多数据
- (void)resetNoMoreData;

/// 结束刷新
- (void)endRefreshing:(BOOL)isHeader;

/// 结束所有刷新
- (void)endAllRefreshing;

@end

NS_ASSUME_NONNULL_END
