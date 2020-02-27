//
//  WJApiHostHelper.h
//  WJBaseProject
//
//  Created by 王杰 on 2020/2/27.
//  Copyright © 2020 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WJApiHostType) {
    WJApiHostTypeDev,               //开发环境
    WJApiHostTypeTest,              //测试环境
    WJApiHostTypeBuss,              //商务环境
    WJApiHostTypeRelease,           //生产环境
};

UIKIT_EXTERN NSString * _Nonnull const kDefaultDesKey;
UIKIT_EXTERN BOOL const kDesEnable;

@interface WJApiHostHelper : NSObject

/**
 获取接口地址
 */
+ (NSString *)getBaseUrl;

/**
 获取上传接口地址
 */
+ (NSString *)getUploadUrl;

/**
根据类型获取接口地址
@param apiHostType 接口地址类型
@return 接口地址
*/
+ (NSString *)getUrlWithType:(WJApiHostType)apiHostType;

/**
根据类型获取上传接口地址
@param apiHostType 上传接口地址类型
@return 上传接口地址
*/
+ (NSString *)getUploadUrlWithType:(WJApiHostType)apiHostType;

@end

NS_ASSUME_NONNULL_END
