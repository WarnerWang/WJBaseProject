//
//  UIScrollView+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/22.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIScrollView+Helpers.h"
#import "MJRefresh.h"

#define imageDuration 0.3
@implementation UIScrollView (Helpers)

+ (UIScrollView *)create{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }
    return scrollView;
}

- (void)scrollToTop {
    [self scrollToTopAnimated:YES];
}

- (void)scrollToBottom {
    [self scrollToBottomAnimated:YES];
}

- (void)scrollToLeft {
    [self scrollToLeftAnimated:YES];
}

- (void)scrollToRight {
    [self scrollToRightAnimated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

- (void)addCustomRefreshHeader:(void (^)(void))headerBlock
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        headerBlock();
    }];
    NSArray *imageArray = [self refreshImages];
    // 设置普通状态的动画图片
    [header setImages:[self refreshImages2] duration:imageDuration*imageArray.count forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:[self refreshImages2] duration:imageDuration*imageArray.count forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:imageArray duration:imageDuration*imageArray.count forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;

    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.mj_header = header;
    [self.mj_header beginRefreshing];
}

- (void)addRefreshHeader:(void (^)(void))headerBlock{
    [self addRefreshHeader:headerBlock isBeginRefresh:YES];
}

- (void)beginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)addRefreshHeader:(void (^)(void))headerBlock isBeginRefresh:(BOOL)isBeginRefresh{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf.mj_footer resetNoMoreData];
        if (headerBlock) {
            headerBlock();
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
    if (isBeginRefresh) {
        [self.mj_header beginRefreshing];
    }
}
/// 移除下拉刷新
- (void)removeRefreshHeader{
    self.mj_header = nil;
}

- (void)addRefreshFooter:(void (^)(void))footerBlock{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        if (footerBlock) {
            footerBlock();
        }

    }];
}

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

/// 重置没有更多数据
- (void)resetNoMoreData{
    [self.mj_footer resetNoMoreData];
}


- (void)endAllRefreshing{
    [self endRefreshing:YES];
    [self endRefreshing:NO];
}

- (void)endRefreshing:(BOOL)isHeader
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isHeader) {
            [self.mj_header endRefreshing];
        }else{
            if (self.mj_footer.state != MJRefreshStateNoMoreData) {
                [self.mj_footer endRefreshing];
            }
        }
    });
}

- (NSArray *)refreshImages{
    NSArray *array = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"hb_regresh_1"],[UIImage imageNamed:@"hb_regresh_2"],[UIImage imageNamed:@"hb_regresh_3"],[UIImage imageNamed:@"hb_regresh_4"], nil];
    return array;
}

- (NSArray *)refreshImages2{
    NSArray *array = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"hb_regresh_4"],[UIImage imageNamed:@"hb_regresh_3"],[UIImage imageNamed:@"hb_regresh_2"],[UIImage imageNamed:@"hb_regresh_1"], nil];
    return array;
}

@end
