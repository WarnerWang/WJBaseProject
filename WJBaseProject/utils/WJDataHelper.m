//
//  WJDataHelper.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJDataHelper.h"
#import "WJ_DATAKEY.h"

@implementation WJDataHelper

// 保存配置数据或简单数据
+(void)saveDataInUserDefaults:(NSString *)key value:(nullable id)value{
    if (!key) {
        return;
    }
    if (value == nil) {
        [self delDataInUserDefaults:key];
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    
    [userDefaults synchronize];
    
}

// 获取数据
+(id)getDataFromUserDefaults:(NSString *)key{
    if (!key) {
        return nil;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:key];
}

// 删除数据
+(void)delDataInUserDefaults:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:key];
    
    [userDefaults synchronize];
}

+(void)saveArrayData:(NSMutableArray *)value key:(NSString *)key{
    if (!value) {
        [self delDataInUserDefaults:key];
    }
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:value];
    
    [self saveDataInUserDefaults:key value:data];
}

+(NSMutableArray *)getArrayData:(NSString *)key{
    NSData *data = [self getDataFromUserDefaults:key];
    if (data == nil) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)saveNeedAchiveData:(nullable id)value key:(NSString *)key{
    
    if (!key) {
        return;
    }
    if (value == nil) {
        [self delDataInUserDefaults:key];
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    [self saveDataInUserDefaults:key value:data];
}

+ (id)getNeedAchiveData:(NSString *)key{
    
    NSData *data = [self getDataFromUserDefaults:key];
    
    if (data == nil) {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

/// 保存用户信息
+ (void)saveUserInfo:(nullable id)userInfo{
    if (userInfo==nil) {
        [self delDataInUserDefaults:kStorageUserInfo];
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    
    [self saveDataInUserDefaults:kStorageUserInfo value:data];
}

/// 获取用户信息
+ (id)getUserInfo{
    NSData *data = [self getDataFromUserDefaults:kStorageUserInfo];
    
    if(data == nil){
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
