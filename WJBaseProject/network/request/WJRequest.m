//
//  WJRequest.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJRequest.h"
#import "NSString+Helpers.h"
#import "WJ_APP_CONFIG.h"

UIKIT_EXTERN NSString *const kDefaultDesKey;
UIKIT_EXTERN BOOL const kDesEnable;

@implementation WJRequestHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userId = @"";
        self.source = @"1";
        self.ip = @"";
        self.xingeToken = @"";
        self.deviceId = [NSString stringWithUUID];
        self.version = [NSString appVersion];
    }
    return self;
}

@end

@implementation WJRequest

+ (NSArray *)modelPropertyBlacklist {
    return @[@"transcode", @"token",@"scretKey"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.token = @"";
        self.userId = @"";
        self.header = [[WJRequestHeader alloc]init];
        self.scretKey = @"";
    }
    return self;
}

- (NSDictionary *)toDictionary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:self.token forKey:@"token"];
    [dict setObject:self.userId forKey:@"userId"];
    //    [dict setObject:self.transcode forKey:@"transcode"];
    [dict setObject:super.yy_modelToJSONString forKey:@"content"];
    
    return dict;
}

- (NSDictionary *)toEncryptDictonary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:self.token forKey:@"token"];
    [dict setObject:self.userId forKey:@"userId"];
    //    [dict setObject:self.transcode forKey:@"transcode"];
    
    NSString *jsonString = super.yy_modelToJSONString;
    if (kDesEnable) {
        NSString *encryptDes = [NSString encryptUseDES:jsonString key:self.scretKey];
        [dict setObject:encryptDes forKey:@"content"];
    }else {
        [dict setObject:jsonString forKey:@"content"];
    }
    
    return dict;
}

- (NSString *)toJsonString{
    return [NSString convertToJsonString:[self toDictionary]];
}

- (NSString *)toEncryptJsonString{
    if (kDesEnable) {
        return [NSString encryptUseDES:[NSString convertToJsonString:[self toEncryptDictonary]] key:kDefaultDesKey];
    }
    return [self toJsonString];
}

@end
