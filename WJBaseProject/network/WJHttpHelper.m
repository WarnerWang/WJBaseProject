//
//  WJHttpHelper.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJHttpHelper.h"
#import "AFNetworking.h"
#import "WJ_APP_CONFIG.h"
#import "NSString+Helpers.h"
#import "WJ_RESPONSE_CODE.h"

typedef NS_ENUM(NSInteger, HttpParamType) {
    HttpParamTypeJson,         //json串
    HttpParamTypeDict,         //字典
};

@implementation WJHttpHelper

/// 改成单例是因为由于ARC机制导致每当实例化session类后都没有地方释放掉实例会造成内存泄露
+(AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20;
    });
    return manager;
}

+(AFURLSessionManager *)sharedURLSession{
    static AFURLSessionManager *urlsession;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        urlsession.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return urlsession;
}

/// 处理请求返回结果
+ (void)handleWithRequest:(WJRequest *)request result:(id)result sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    if (DES_ENABLE) {
#ifdef DEBUG
        NSLog(@"返回解密前的数据：%@",result);
#endif
        result = [((NSString *)result) decryptUseDES:DES_KEY];
        
#ifdef DEBUG
        NSLog(@"返回解密数据 transcode：%@ -- result：%@",request.transcode,result);
#endif
    }else {
#ifdef DEBUG
        NSLog(@"返回数据 transcode：%@ -- result：%@",request.transcode,result);
#endif
    }
    
    WJResponse *response = [WJResponse yy_modelWithJSON:result];
    if ([response.errCode isEqualToString:kNetworkSuccess]) {
        if (sucBlock) {
            sucBlock(result);
        }
    }else {
        if (responseErrorBlock) {
            
            responseErrorBlock(response);
            if ([response.errCode isEqualToString:kLoginTimeout] || [response.errCode isEqualToString:kTokenIsEmpty]) {
                //                    [BCUtils logoutToLogin];
            }
            
        }
    }
    if (endRefreshBlock) {
        endRefreshBlock();
    }
}

/// 处理Http错误
+ (void)handleWothError:(NSError *)error responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    NSString *errorMsg = @"未知错误，请稍后再试！";
    if(error.code == NSURLErrorNotConnectedToInternet){
        errorMsg = @"网络未连接！";
    }else if (error.code == NSURLErrorNetworkConnectionLost){
        errorMsg = @"网络连接中断，请稍后再试";
    }else if (error.code==NSURLErrorCannotFindHost || error.code ==NSURLErrorCannotConnectToHost){
        errorMsg = @"无法连接到服务器，请稍后再试";
    }else if (error.code==NSURLErrorTimedOut) {
        
        errorMsg = @"服务器连接超时，请稍后再试";
        
    }
    WJResponse *response = [[WJResponse alloc]init];
    response.errCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    response.errMsg = errorMsg;
    if (responseErrorBlock) {
        responseErrorBlock(response);
    }
    
    if (endRefreshBlock) {
        endRefreshBlock();
    }
}

#pragma mark post
+(void)postRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    [self postRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock filePaths:@[] paramType:HttpParamTypeJson];
}

+(void)post:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    [self postRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock filePaths:@[] paramType:HttpParamTypeDict];
}

+(void)postRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock paramType:(HttpParamType)paramType{
    [self postRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock filePaths:@[] paramType:paramType];
}

+ (void)postRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock filePaths:(NSArray *)filePaths{
    [self postRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock filePaths:@[] paramType:HttpParamTypeDict];
}

+ (void)postRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock filePaths:(NSArray *)filePaths  paramType:(HttpParamType)paramType{
    
    [self postWithURLString:@"" request:request completeBlock:^(id result) {
        
        [self handleWithRequest:request result:result sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock];
        
    } errorBlock:^(NSError *error) {
        
        [self handleWothError:error responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock];
        
        
    } beforeBlock:nil endBlock:nil filePaths:filePaths paramType:paramType];
    
}

+(void)postWithURLString:(NSString *)urlStr request:(WJRequest *) request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock filePaths:(NSArray *)filePaths  paramType:(HttpParamType)paramType{
    if (filePaths.count == 0) {
        [self postWithURLString:urlStr request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock paramType:paramType];
    }else {
        [self uploadTaskWithURLString:urlStr request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock filePaths:filePaths];
    }
    
}

+(void)postWithURLString:(NSString *)urlStr request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock paramType:(HttpParamType)paramType{
    
    if (beforeBlock != nil) {
        beforeBlock();
    }
    id params = nil;
    if (paramType == HttpParamTypeDict) {
        params = [request toEncryptDictonary];
    }else {
        params = [request toJsonString];
    }
    
    if ([NSString isEmpty:urlStr]) {
        if (DES_ENABLE) {
            urlStr = [[DES_BASE_URL stringByAppendingString:request.transcode] copy];
        }else {
            urlStr = [[BASE_URL stringByAppendingString:request.transcode] copy];
        }
        
    }
    
#ifdef DEBUG
    
    if (DES_ENABLE) {
        NSLog(@"请求加密前：%@ \n url:%@",[request toJsonString],urlStr);
        
        NSLog(@"请求加密后：%@",params);
        
    }else {
        NSLog(@"请求参数： %@,url:%@",params,urlStr);
    }
    
#endif
    
    if (paramType == HttpParamTypeDict) {
        [self postWithURLString:urlStr paramDict:params request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock];
    }else {
        [self postWithURLString:urlStr paramJson:params request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock];
    }
    
}

+(void)postWithURLString:(NSString *)urlStr paramJson:(NSString *)params request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock{
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    [urlRequest setHTTPMethod:@"POST"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * tesk = [manager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"error is %@", error);
            
            if (errorBlock != nil) {
                errorBlock(error);
            }
            if (endBlock != nil) {
                endBlock();
            }
        } else {
            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (finishBlock != nil) {
                finishBlock(str);
            }
            if (endBlock != nil) {
                endBlock();
            }
        }
    }];
    [tesk resume];
    
}

+(void)postWithURLString:(NSString *)urlStr paramDict:(NSDictionary *)params request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock{
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if (finishBlock != nil) {
            finishBlock(str);
        }
        if (endBlock != nil) {
            endBlock();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error is %@", error);
        
        if (errorBlock != nil) {
            errorBlock(error);
        }
        if (endBlock != nil) {
            endBlock();
        }
        
    }];
}


#pragma mark upload上传
+(void)uploadTaskWithURLString:(NSString *)urlStr request:(WJRequest *) request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock filePaths:(NSArray *)filePaths{
    
    
    if (beforeBlock != nil) {
        beforeBlock();
    }
    
    NSDictionary *params = [request toDictionary];
    
    
    if ([NSString isEmpty:urlStr]) {
        if (DES_ENABLE) {
            urlStr = [DES_UPLOAD_URL copy];
        }else {
            urlStr = [UPLOAD_URL copy];
        }
    }
    
#ifdef DEBUG
    
        if (DES_ENABLE) {
            NSLog(@"请求加密前：%@ \n url:%@",[request toDictionary],urlStr);
        }else {
            NSLog(@"请求参数： %@,url:%@",params,urlStr);
        }
#endif
    
    NSMutableURLRequest *req = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSString *filePath in filePaths) {
            
            if ([filePath containsString:@".mp4"]) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"filename.mp4" mimeType:@"video/quicktime" error:nil];
            }else if ([filePath containsString:@".amr"]) {
                
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"filename.amr" mimeType:@"audio/amr" error:nil];
                
            }else{
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
            }
        }
        
    } error:nil];
    
    AFURLSessionManager *manager = [self sharedURLSession];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:req progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
            NSLog(@"error is %@", error);
            
            if (errorBlock != nil) {
                errorBlock(error);
            }
            if (endBlock != nil) {
                endBlock();
            }
        } else {
            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (finishBlock != nil) {
                finishBlock(str);
            }
            if (endBlock != nil) {
                endBlock();
            }
        }
    }];
    
    [uploadTask resume];
}



#pragma mark GET
+(void)getRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    [self getRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock paramType:HttpParamTypeJson];
}

+(void)get:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock{
    
    [self getRequest:request sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock paramType:HttpParamTypeDict];
}

+ (void)getRequest:(WJRequest *)request sucBlock:(PostRequestSucBlock)sucBlock responseErrorBlock:(ResponseErrorBlock)responseErrorBlock endRefreshBlock:(EndRefreshBlock)endRefreshBlock paramType:(HttpParamType)paramType{
    
    [self getWithURLString:@"" request:request completeBlock:^(id result) {
        
        [self handleWithRequest:request result:result sucBlock:sucBlock responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock];
        
    } errorBlock:^(NSError *error) {
        
        [self handleWothError:error responseErrorBlock:responseErrorBlock endRefreshBlock:endRefreshBlock];
        
    } beforeBlock:nil endBlock:nil paramType:paramType];
    
}


+(void)getWithURLString:(NSString *)urlStr request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock paramType:(HttpParamType)paramType{
    
    if (beforeBlock != nil) {
        beforeBlock();
    }
    id params = nil;
    if (paramType == HttpParamTypeDict) {
        params = [request toEncryptDictonary];
    }else {
        params = [request toJsonString];
    }
    
    if ([NSString isEmpty:urlStr]) {
        if (DES_ENABLE) {
            urlStr = [[DES_BASE_URL stringByAppendingString:request.transcode] copy];
        }else {
            urlStr = [[BASE_URL stringByAppendingString:request.transcode] copy];
        }
        
    }
    
#ifdef DEBUG
    
    if (DES_ENABLE) {
        NSLog(@"请求加密前：%@ \n url:%@",[request toJsonString],urlStr);
        
        NSLog(@"请求加密后：%@",params);
        
    }else {
        NSLog(@"请求参数： %@,url:%@",params,urlStr);
    }
    
#endif
    
    if (paramType == HttpParamTypeDict) {
        [self getWithURLString:urlStr paramDict:params request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock];
    }else {
        [self getWithURLString:urlStr paramJson:params request:request completeBlock:finishBlock errorBlock:errorBlock beforeBlock:beforeBlock endBlock:endBlock];
    }
    
}

+(void)getWithURLString:(NSString *)urlStr paramJson:(NSString *)params request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock{
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    [urlRequest setHTTPMethod:@"GET"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * tesk = [manager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"error is %@", error);
            
            if (errorBlock != nil) {
                errorBlock(error);
            }
            if (endBlock != nil) {
                endBlock();
            }
        } else {
            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (finishBlock != nil) {
                finishBlock(str);
            }
            if (endBlock != nil) {
                endBlock();
            }
        }
    }];
    [tesk resume];
    
}


+(void)getWithURLString:(NSString *)urlStr paramDict:(NSDictionary *)params request:(WJRequest *)request completeBlock:(RequestFinishBlock)finishBlock errorBlock:(RequestErrorBlock)errorBlock beforeBlock:(DefaultBlock)beforeBlock endBlock:(DefaultBlock)endBlock{
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if (finishBlock != nil) {
            finishBlock(str);
        }
        if (endBlock != nil) {
            endBlock();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error is %@", error);
        
        if (errorBlock != nil) {
            errorBlock(error);
        }
        if (endBlock != nil) {
            endBlock();
        }
        
    }];
}



#pragma mark download下载
/// 下载文件
+ (void)downloadWithUrlStr:(NSString *)urlStr filePath:(NSString *)filePath complete:(void(^)(NSString *filePath,NSProgress *progress,FileDownloadStatus downloadStatus))complete{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:filePath.lastPathComponent];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //文件已存在
        if (complete) {
            complete(path,nil,FileDownloadStatusSuccess);
        }
        return;
    }
    
    
    
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (complete) {
            complete(nil,downloadProgress,FileDownloadStatusDownloading);
        }
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        return [NSURL fileURLWithPath:path]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
        FileDownloadStatus downloadStatus = FileDownloadStatusUnStart;
        if (error) {
            downloadStatus = FileDownloadStatusFailed;
        }else {
            downloadStatus = FileDownloadStatusSuccess;
        }
        if (complete) {
            complete([filePath path],nil,downloadStatus);
        }
    }];
    // 5.启动下载任务
    [task resume];
}

+ (void)startMonitoringNetWorkChanged:(void(^)(NetWorkStateChangedType netWorkState))complete{
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        NetWorkStateChangedType state = NetWorkStateChangedTypeUnknown;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                state = NetWorkStateChangedTypeUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                state = NetWorkStateChangedTypeNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                state = NetWorkStateChangedTypeReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                state = NetWorkStateChangedTypeReachableViaWiFi;
                break;
                
            default:
                break;
        }
        if (complete) {
            complete(state);
        }
        
        
    }];
}

+ (void)stopMonitoringNetWork{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
