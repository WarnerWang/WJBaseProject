//
//  WJApiHostHelper.m
//  WJBaseProject
//
//  Created by 王杰 on 2020/2/27.
//  Copyright © 2020 和信金谷. All rights reserved.
//

#import "WJApiHostHelper.h"
#import "NSString+Helpers.h"

// 开发环境
NSString* const kDevBaseUrl = @"http://dev.hexinjingu.com/";
// 测试环境
NSString* const kTestBaseUrl = @"http://test.hexinjingu.com/";
// 商务测试环境
NSString* const kBussBaseUrl = @"http://www.hexinjingu.natapp1.cc/";
// 生产环境
NSString* const kReleaseBaseUrl = @"https://www.88lot.com/";
//加密接口地址
NSString* const kApiPathDes = @"sports_web_mobile_transfer/main/";

//非加密接口地址
NSString* const kApiPath = @"sports_web_mobile_transfer/service/";

// 上传地址
NSString* const kUploadUrl = @"sports_web_mobile_transfer/fileUpload/upload/";

// 上传加密地址
NSString* const kUploadUrlDes = @"sports_web_mobile_transfer/fileUpload/upload/";

// 默认秘钥
NSString* const kDefaultDesKey = @"hxsports";


NSString* const kH5Prefix = @"https://www.88lot.com/sports_web_h5/";

// 接口是否加密
BOOL const kDesEnable = true;

@implementation WJApiHostHelper

+ (NSString *)getHostWithType:(WJApiHostType)apiHostType{
    NSString* host = @"";
    switch (apiHostType) {
        case WJApiHostTypeDev:
            host = kDevBaseUrl;
            break;
        case WJApiHostTypeTest:
            host = kTestBaseUrl;
            break;
        case WJApiHostTypeBuss:
            host = kBussBaseUrl;
            break;
        case WJApiHostTypeRelease:
            host = kReleaseBaseUrl;
            break;
        default:
            break;
    }
    return host;
}

/**
 获取接口地址
 */
+ (NSString *)getBaseUrl{
    return [self getUrlWithType:[self getApiHostType]];
}

/**
 获取上传接口地址
 */
+ (NSString *)getUploadUrl{
    return [self getUploadUrlWithType:[self getApiHostType]];
}

+ (WJApiHostType)getApiHostType{
    return WJApiHostTypeRelease;
}

/**
 根据类型获取接口地址
 @param apiHostType 接口地址类型
 @return 接口地址
 */
+ (NSString *)getUrlWithType:(WJApiHostType)apiHostType{
    NSString* baseUrl = [self getHostWithType:apiHostType];
    if (![NSString isEmpty:baseUrl]) {
        baseUrl = [NSString stringWithFormat:@"%@%@",baseUrl,kDesEnable ? kApiPathDes : kApiPath];
    }
    return baseUrl;
}

/**
根据类型获取上传接口地址
@param apiHostType 上传接口地址类型
@return 上传接口地址
*/
+ (NSString *)getUploadUrlWithType:(WJApiHostType)apiHostType{
    NSString* uploadUrl = [self getHostWithType:apiHostType];
    if (![NSString isEmpty:uploadUrl]) {
        uploadUrl = [NSString stringWithFormat:@"%@%@",uploadUrl,kDesEnable ? kUploadUrlDes : kUploadUrl];
    }
    return uploadUrl;
}

@end
