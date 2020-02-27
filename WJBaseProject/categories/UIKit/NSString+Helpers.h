//
//  NSString+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Helpers)

/**
 判断是否为空串
 */
+(BOOL)isEmpty:(NSString*)text;

///判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

/// 判断是否为浮点型
+ (BOOL)isPureFloat:(NSString *)string;

/**
 *  判断string是否为整数
 *  @param value 浮点型值
 *  @return 是整数则返回yes，否则返回no
 */
+ (BOOL)isPureIntFromFloat:(CGFloat)value;

/**
 *  将float型数据以string返回
 *  @param value 浮点型值
 *  @return 返回格式化后的float数据
 */
+ (NSString *)formatStrWithFloat:(CGFloat)value;

/// 无空格字符串
- (NSString*)noneSpaseString;

/// 校验手机号
+(BOOL)validateMobile:(NSString *)mobile;

/// 校验email
+ (BOOL)validateEmail:(NSString *)email;

/// 身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/// 昵称 3-10个汉字、字母或者相互组合
+ (BOOL)validNickName:(NSString *)nickName;

/// 校验密码
+ (BOOL)validPassward:(NSString *)passward;

/// 真实姓名 2-6个汉字
+ (BOOL)validRealName:(NSString *)realName;

/// 将数字转为每隔3位整数由逗号“,”分隔的字符串
- (NSString *)separateNumberUseComma;

/// 用*代替range范围的文本 常用于手机号显示
- (NSString *)replaceWithScureInRange:(NSRange)range;

/// MD5加密-16位
- (NSString *)md5;

/// MD5加密-32位
- (NSString *)md5_32;

/// DES加密
+(NSString *)encryptUseDES:(NSString *)string key:(NSString *)key;

/// des 解密
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key;

/// app版本号
+ (NSString *)appVersion;

/// app名称
+ (NSString *)appName;

/// app bundle id
+ (NSString *)appBundleID;

/// 比较版本号
- (BOOL)hasNewVersion;

/// 计算尺寸
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineSpace:(CGFloat)lineSpace mode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace;

+ (NSString *)stringWithUUID;

/// 字典转JsonString
+(NSString *)convertToJsonString:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
