//
//  UIImageView+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ImageUrlType) {
    ImageUrlTypeNormal,
    ImageUrlTypeSmall,
    ImageUrlTypeBig,
};

@interface UIImageView (Helpers)

+(UIImageView *)createImageV;

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName;

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode;

/**
 * 加载图片
 * @param urlStr   图片地址
 */
- (void)setImageWithUrlStr:(NSString *)urlStr;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr imageUrlType:(ImageUrlType)imageUrlType;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param endBlock 加载结束回调
 */
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(nullable void(^)(BOOL isSuccess))endBlock;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param endBlock 加载结束回调
 * @param imageUrlType 图片规格
 */
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(nullable void(^)(BOOL isSuccess))endBlock imageUrlType:(ImageUrlType)imageUrlType;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName imageUrlType:(ImageUrlType)imageUrlType;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param endBlock 加载结束回调
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param endBlock 加载结束回调
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock imageUrlType:(ImageUrlType)imageUrlType;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param complete 获取到的图片对象
 */
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param complete 获取到的图片对象
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType;

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 缺省图片
 * @param complete 获取到的图片对象
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(nonnull NSString *)placeHolderName complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType;

@end

NS_ASSUME_NONNULL_END
