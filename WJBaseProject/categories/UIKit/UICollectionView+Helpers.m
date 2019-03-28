//
//  UICollectionView+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UICollectionView+Helpers.h"

@implementation UICollectionView (Helpers)

+ (UICollectionView *)create:(CGSize)spaceSize itemSize:(CGSize)itemSize target:(__autoreleasing id<UICollectionViewDelegate,UICollectionViewDataSource>)target{
    
    return [self create:spaceSize itemSize:itemSize target:target sectionInsets:UIEdgeInsetsZero];
}

+ (UICollectionView *)create:(CGSize)spaceSize itemSize:(CGSize)itemSize target:(__autoreleasing id<UICollectionViewDelegate,UICollectionViewDataSource>)target sectionInsets:(UIEdgeInsets)sectionIndets{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = spaceSize.width;
    layout.minimumInteritemSpacing = spaceSize.height;
    if (!CGSizeEqualToSize(itemSize, CGSizeZero)) {
        layout.itemSize = itemSize;
    }
    layout.sectionInset = sectionIndets;
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionV.backgroundColor = [UIColor clearColor];
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.delegate = target;
    collectionV.dataSource = target;
    return collectionV;
}

@end
