//
//  WJRequest.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJRequestHeader : WJBaseModel

@property (nonatomic,copy) NSString* userId;
@property (nonatomic,copy) NSString* source;//来源ip 1 iosapp 2 androidapp 3 微信 4 h5
@property (nonatomic,copy) NSString* ip;
@property (nonatomic,copy) NSString* xingeToken;
@property (nonatomic,copy) NSString* deviceId;//设备唯一id
@property (nonatomic,copy) NSString* version;

@end

@interface WJRequest : WJBaseModel

@property (nonatomic,strong) WJRequestHeader *header;
@property (nonatomic,copy) NSString* transcode;//交易代码--由服务方指定，服务器方会根据交易码进行请求处理 （不能为空）
@property (nonatomic,copy) NSString* token;//用户登录token
@property (nonatomic,copy) NSString* userId;
@property (nonatomic,copy) NSString* scretKey;

#pragma mark 参数为字典时使用以下两个方法生成参数
/// 非加密参数
- (NSDictionary *)toDictionary;
/// 加密参数
- (NSDictionary *)toEncryptDictonary;

#pragma mark 参数为json串时使用以下两个方法生成参数
/// 非加密参数
- (NSString *)toJsonString;
/// 加密参数
- (NSString *)toEncryptJsonString;


@end

NS_ASSUME_NONNULL_END
