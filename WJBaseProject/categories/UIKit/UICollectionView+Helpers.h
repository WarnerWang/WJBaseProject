//
//  UICollectionView+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Helpers)

+ (UICollectionView *)create:(CGSize)spaceSize itemSize:(CGSize)itemSize target:(__autoreleasing id<UICollectionViewDelegate,UICollectionViewDataSource>)target;

+ (UICollectionView *)create:(CGSize)spaceSize itemSize:(CGSize)itemSize target:(__autoreleasing id<UICollectionViewDelegate,UICollectionViewDataSource>)target sectionInsets:(UIEdgeInsets)sectionIndets;

@end

NS_ASSUME_NONNULL_END
