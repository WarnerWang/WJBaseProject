//
//  WJRequest.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//
/**
 当前默认的请求格式为：
 {
     token:""
     userId:""
     content:{
         header:{
             userId:""
             source:""
             ip:""
             xingeToken:""
             deviceId:""
             version:""
         }
         userId:""
     }
 }
 
 关于WJRequest：
 调用WJHttpHelper进行网络请求时的参数request只需继承自WJRequest即可
 所有的param内容只需要当做属性写在继承的WJRequest中然后赋值即可
 继承自WJRequest类中的属性会放在content内容中。
 如果请求格式不符合需求只需自行更改WJRequest.m中
 - (NSDictionary *)toDictionary 和- (NSDictionary *)toEncryptDictonary
 这两个方法中的内容即可
 
 关于WJResponse：
 请求结果需继承自WJResponse
 转model需调用 Class *response = [Class yy_modelWithJSON:jsonString];
 Class为创建的继承自WJResponse的对象
 */

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
