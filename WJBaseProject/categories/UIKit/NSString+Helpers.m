//
//  NSString+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

@implementation NSString (Helpers)

+(BOOL)isEmpty:(NSString*)text{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    } else if ([@"" isEqualToString:text]){
        
        return YES;
    }
    return NO;
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/// 判断是否为浮点型
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  判断string是否为整数
 *  @param value 浮点型值
 *  @return 是整数则返回yes，否则返回no
 */
+ (BOOL)isPureIntFromFloat:(CGFloat)value{
    double err = 1e-6; //先自己定义误差
    if (fabs(((int)value)-value)< err) {
        return YES;
    }
    return NO;
}

/**
 *  将float型数据以string返回
 *  @param value 浮点型值
 *  @return 返回格式化后的float数据
 */
+ (NSString *)formatStrWithFloat:(CGFloat)value{
    if ([NSString isPureIntFromFloat:value]) {
        return [NSString stringWithFormat:@"%.0f",value];
    }else {
        NSString *onePointFloat = [NSString stringWithFormat:@"%.1f",value];
        NSString *twoPointFloat = [NSString stringWithFormat:@"%.2f",value];
        double err = 1e-6; //先自己定义误差
        if (fabs(onePointFloat.floatValue-twoPointFloat.floatValue)< err) {
            return onePointFloat;
        }
        return twoPointFloat;
    }
}

/// 无空格字符串
- (NSString*)noneSpaseString
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+(BOOL)validateMobile:(NSString *) mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    //    return [phoneTest evaluateWithObject:mobile];
    
    if ([NSString isEmpty:mobile]) {
        return NO;
    }
    
    NSString *mobileRegex = @"^((13[0-9])|(147)|(17[0-9]|)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    BOOL n = [mobileTest evaluateWithObject:mobile];
    
    
    return n;
    
}

+ (BOOL)validateEmail:(NSString *) email{
    if ([NSString isEmpty:email]) {
        return NO;
    }
    
    NSString *mobileRegex = @"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    BOOL n = [mobileTest evaluateWithObject:email];
    
    return n;
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{18,18}|\\d{15,15}|\\d{17,17}x)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/// 昵称 3-10个汉字、字母或者相互组合
+ (BOOL)validNickName:(NSString *)nickName{
    
    if ([NSString isEmpty:nickName]) {
        return NO;
    }
    
    NSString *nikeNameRegex = @"^[1-9a-zA-Z\u4e00-\u9fa5]{3,15}$";
    NSPredicate *nickNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nikeNameRegex];
    return [nickNamePredicate evaluateWithObject:nickName];
    
}

///校验密码
+ (BOOL)validPassward:(NSString *)passward{
    if ([NSString isEmpty:passward]) {
        return NO;
    }
    
    NSString *passwardeRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![!@%^*_+<>?#*%&',;=?$\x22]+$)[1-9a-zA-Z!@%^*_+<>?#*%&',;=?$\x22]{6,20}$";
    NSPredicate *passwardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwardeRegex];
    return [passwardPredicate evaluateWithObject:passward];
}

/// 真实姓名 2-6个汉字
+ (BOOL)validRealName:(NSString *)realName{
    if ([NSString isEmpty:realName]) {
        return NO;
    }
    
    NSString *realNameRegex = @"^[\u4e00-\u9fa5]{2,6}$";
    NSPredicate *realNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realNameRegex];
    return [realNamePredicate evaluateWithObject:realName];
}


/// 将数字转为每隔3位整数由逗号“,”分隔的字符串
- (NSString *)separateNumberUseComma{
    if ([NSString isEmpty:self]) {
        return @"0";
    }
    if (![NSString isPureInt:self] && ![NSString isPureFloat:self]) {
        return self;
    }
    BOOL contains = NO;
    // 分隔符
    NSString *divide = @",";
    NSString *integer = @"";
    NSString *radixPoint = @"";
    if ([self containsString:@"."]) {
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [self componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
    }else {
        integer = self;
    }
    // 将整数按各个字符为一组拆分成数组
    NSUInteger count = integer.length;
    NSMutableString *string = [NSMutableString stringWithString:integer];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:divide atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    if ([NSString isEmpty:newstring]) {
        return @"0";
    }
    return newstring;
}

/// 用*代替range范围的文本
- (NSString *)replaceWithScureInRange:(NSRange)range{
    if (self.length > 0) {
        NSString *scureStr = @"";
        for (NSInteger i = 0; i<range.length; i++) {
            scureStr = [scureStr stringByAppendingString:@"*"];
        }
        return [self stringByReplacingCharactersInRange:range withString:scureStr];
    }
    return self;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7]
            ];
}

- (NSString *)md5_32{
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

/// DES加密
- (NSString *)encryptUseDes:(NSString *)key{
    NSString *result = nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        result = [[NSString alloc] initWithData:[GTMBase64 encodeData:resultData] encoding:NSUTF8StringEncoding];
    }
    
    free(buffer);
    return result;
}

/// DES解密
- (NSString *)decryptUseDES:(NSString *)key{
    NSString *cipherText = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [cipherData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data= [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    free(buffer);
    
    return nil;
}

+ (NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

/// 比较版本号
- (BOOL)hasNewVersion{
    NSString *localVersion = [NSString appVersion];
    NSArray *serviceArr = [self componentsSeparatedByString:@"."];
    NSArray *localArr = [localVersion componentsSeparatedByString:@"."];
    BOOL hasNew = NO;
    for (NSInteger i = 0; i<serviceArr.count; i++) {
        NSInteger serviceINum = [serviceArr[i] integerValue];
        if (i >= localArr.count) {
            if (serviceINum > 0) {
                hasNew = YES;
                break;
            }
            continue;
        }
        NSInteger localINum = [localArr[i] integerValue];
        if (serviceINum > localINum) {
            hasNew = YES;
            break;
        }
        if (serviceINum < localINum) {
            break;
        }
    }
    return hasNew;
}


- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineSpace:(CGFloat)lineSpace mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping || lineSpace != 0) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            if (lineBreakMode != NSLineBreakByWordWrapping) {
                paragraphStyle.lineBreakMode = lineBreakMode;
                attr[NSParagraphStyleAttributeName] = paragraphStyle;
            }
            if (lineSpace != 0) {
                [paragraphStyle setLineSpacing:lineSpace];
                attr[NSParagraphStyleAttributeName] = paragraphStyle;
            }
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size{
    return [self sizeForFont:font size:size lineSpace:0 mode:NSLineBreakByWordWrapping];
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) lineSpace:0 mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    return [self heightForFont:font width:width lineSpace:0];
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) lineSpace:lineSpace mode:NSLineBreakByWordWrapping];
    return size.height;
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

/// 字典转JsonString
+(NSString *)convertToJsonString:(NSDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}

@end
