//
//  UIImageView+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIImageView+Helpers.h"
#import "UIColor+Helpers.h"
#import "NSString+Helpers.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Helpers)

+(UIImageView *)createImageV{
    return [UIImageView new];
}

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    return imageV;
}

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    UIImageView *imageV = [UIImageView createImageViewWithImageName:imageName];
    imageV.contentMode = contentMode;
    return imageV;
}


/**
 * 加载图片
 * @param urlStr   图片地址
 */
- (void)setImageWithUrlStr:(NSString *)urlStr{
    
    [self setImageWithUrlStr:urlStr endBlock:nil imageUrlType:ImageUrlTypeNormal];
}


/**
 * 加载图片
 * @param urlStr   图片地址
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr imageUrlType:(ImageUrlType)imageUrlType{
    
    [self setImageWithUrlStr:urlStr endBlock:nil imageUrlType:imageUrlType];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param endBlock 加载结束回调
 */
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(void(^)(BOOL isSuccess))endBlock{
    
    [self setImageWithUrlStr:urlStr placeHolderName:[self getPlaceholderName] endBlock:endBlock imageUrlType:ImageUrlTypeNormal];
}


/**
 * 加载图片
 * @param urlStr   图片地址
 * @param endBlock 加载结束回调
 * @param imageUrlType 图片规格
 */
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(nullable void (^)(BOOL))endBlock imageUrlType:(ImageUrlType)imageUrlType{
    [self setImageWithUrlStr:urlStr placeHolderName:[self getPlaceholderName] endBlock:endBlock imageUrlType:imageUrlType];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName{
    [self setImageWithUrlStr:urlStr placeHolderName:placeHolderName endBlock:nil imageUrlType:ImageUrlTypeNormal];
}


/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName imageUrlType:(ImageUrlType)imageUrlType{
    [self setImageWithUrlStr:urlStr placeHolderName:placeHolderName endBlock:nil imageUrlType:imageUrlType];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param endBlock 加载结束回调
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock{
    [self setImageWithUrlStr:urlStr placeHolderName:placeHolderName endBlock:endBlock imageUrlType:ImageUrlTypeNormal];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 本地缺省图片
 * @param endBlock 加载结束回调
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock imageUrlType:(ImageUrlType)imageUrlType{
    
    if ([NSString isEmpty:urlStr]) {
        if (![NSString isEmpty:placeHolderName]) {
            self.image = [UIImage imageNamed:placeHolderName];
        }
        return;
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:[UIImageView urlStr:urlStr type:imageUrlType]] placeholderImage:[UIImage imageNamed:placeHolderName] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            
            if (endBlock) {
                endBlock(YES);
            }
        }else {
            NSLog(@"image load eror : %@",error.description);
            if (endBlock) {

                endBlock(NO);
            }
        }
    }];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param complete 获取到的图片对象
 */
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete{
    [self setImageWithUrlStr:urlStr complete:complete imageUrlType:ImageUrlTypeNormal];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param complete 获取到的图片对象
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType{
    [self setImageWithUrlStr:urlStr placeHolderName:[self getPlaceholderName] complete:complete imageUrlType:imageUrlType];
}

/**
 * 加载图片
 * @param urlStr   图片地址
 * @param placeHolderName 缺省图片
 * @param complete 获取到的图片对象
 * @param imageUrlType 图片规格
 */
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(nonnull NSString *)placeHolderName complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType{
    if ([NSString isEmpty:urlStr]) {
        if (![NSString isEmpty:placeHolderName]) {
            self.image = [UIImage imageNamed:placeHolderName];
        }
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:[UIImageView urlStr:urlStr type:imageUrlType]] placeholderImage:[UIImage imageNamed:placeHolderName] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (complete && !error) {
            if (complete(image)) {
                self.image = complete(image);
            }
        }
    }];
}


- (NSString *)getPlaceholderName{
//    CGSize size = self.frame.size;
    return @"";
}


+ (NSString *)urlStr:(NSString *)urlStr type:(ImageUrlType)type{
    if ([urlStr hasSuffix:@".png"]||[urlStr hasSuffix:@".jpg"]||[urlStr hasSuffix:@".jpeg"]) {
        if (type == ImageUrlTypeSmall) {
            urlStr = [urlStr stringByReplacingOccurrencesOfString:@"." withString:@"_thumb."];
        }
    }
    return urlStr;
}

@end
