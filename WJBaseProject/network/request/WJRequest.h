//
//  WJRequest.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//
/**
 基于YYModel和AFNetworking二次封装的网络库
 YYModel的使用请移步 https://github.com/ibireme/YYModel
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
/// 接口地址后缀 baseUrl后面拼接上此参数为完整的请求地址(使用时只需子类在初始化方法中赋值即可  例：self.transcode = @"/userServiceI/login")
@property (nonatomic,copy,nonnull) NSString* transcode;
@property (nonatomic,copy) NSString* token;//用户登录token
@property (nonatomic,copy) NSString* userId;
/// 加密密钥 默认是登录秘钥，非登录接口使用默认密钥(只需子类在初始化方法中令self.scretKey = DES_KEY即可)
@property (nonatomic,copy) NSString* scretKey;

#pragma mark 参数为字典时使用以下两个方法生成参数
/// 非加密参数
- (NSDictionary *)toDictionary;
/// 加密参数--一层加密，只给content加密，秘钥为self.scretKey
- (NSDictionary *)toEncryptDictonary;

#pragma mark 参数为json串时使用以下两个方法生成参数
/// 非加密参数
- (NSString *)toJsonString;
/// 加密参数 -- 两层加密，第一层给content加密，秘钥为self.scretKey，第二层给整体加密，秘钥为默认密钥 DES_KEY
- (NSString *)toEncryptJsonString;


@end

NS_ASSUME_NONNULL_END
