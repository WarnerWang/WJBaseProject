//
//  WJDataHelper.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDataHelper : NSObject

/// 保存配置数据或简单数据
+(void)saveDataInUserDefaults:(NSString *)key value:(nullable id)value;

/// 获取数据
+(id)getDataFromUserDefaults:(NSString *)key;

/// 删除数据
+(void)delDataInUserDefaults:(NSString *)key;

/// 保存可变数组
+(void)saveArrayData:(NSMutableArray *)value key:(NSString *)key;

/// 获取可变数组
+(NSMutableArray *)getArrayData:(NSString *)key;

/// 保存需要归档的数据
+ (void)saveNeedAchiveData:(nullable id)value key:(NSString *)key;

/// 获取需要归档的数据
+ (id)getNeedAchiveData:(NSString *)key;

/// 保存用户信息
+ (void)saveUserInfo:(nullable id)userInfo;

/// 获取用户信息
+ (id)getUserInfo;

@end

NS_ASSUME_NONNULL_END
