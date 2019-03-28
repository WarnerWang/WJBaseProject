//
//  WJHttpHelper.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRequest.h"
#import "WJResponse.h"

typedef void(^RequestFinishBlock)(id result);
typedef void(^RequestErrorBlock)(NSError *error);
typedef void(^ResponseErrorBlock)(WJResponse *respError);
typedef void(^PostRequestSucBlock)(NSString* jsonString);
typedef void(^DefaultBlock)(void);
typedef void(^EndRefreshBlock)(void);

typedef NS_ENUM(NSInteger,NetWorkStateChangedType) {
    NetWorkStateChangedTypeNotReachable,  //没有网络
    NetWorkStateChangedTypeUnknown,       //未知网络
    NetWorkStateChangedTypeReachableViaWWAN,  //手机网络
    NetWorkStateChangedTypeReachableViaWiFi,  //WiFi
};

typedef NS_ENUM(NSInteger, FileDownloadStatus) {
    FileDownloadStatusUnStart,         //未开始
    FileDownloadStatusDownloading,     //下载中
    FileDownloadStatusSuccess,         //下载成功
    FileDownloadStatusFailed,          //下载失败
};

NS_ASSUME_NONNULL_BEGIN

@interface WJHttpHelper : NSObject

/**
 普通post请求 -- 以json串为请求参数
 @param request 请求对象
 @param sucBlock 成功回调
 @param responseErrorBlock 失败回调
 @param endRefreshBlock 结束回调
 */
+(void)postRequest:(WJRequest *) request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock;

/**
 普通post请求 -- 以dict为请求参数
 @param request 请求对象
 @param sucBlock 成功回调
 @param responseErrorBlock 失败回调
 @param endRefreshBlock 结束回调
 */
+(void)post:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock;


/**
 普通get请求 -- 以json串为请求参数
 @param request 请求对象
 @param sucBlock 成功回调
 @param responseErrorBlock 失败回调
 @param endRefreshBlock 结束回调
 */
+(void)getRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock;


/**
 普通get请求 -- 以dict为请求参数
 @param request 请求对象
 @param sucBlock 成功回调
 @param responseErrorBlock 失败回调
 @param endRefreshBlock 结束回调
 */
+(void)get:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock;

/**
 上传文件
 */
+(void)postRequest:(WJRequest *) request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock filePaths:(NSArray *)filePaths;

/// 下载文件
+ (void)downloadWithUrlStr:(NSString *)urlStr filePath:(NSString *)filePath complete:(void(^)(NSString *filePath,NSProgress *progress,FileDownloadStatus downloadStatus))complete;

/**
 开始检测网络状态
 */
+ (void)startMonitoringNetWorkChanged:(void(^)(NetWorkStateChangedType netWorkState))complete;

/**
 停止检测网络状态
 */
+ (void)stopMonitoringNetWork;

@end

NS_ASSUME_NONNULL_END
