//
//  UIDevice+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DeviceModel) {
    UnKnown,                  //逻辑分辨率       物理分辨率
    Simulator,
    iPhone4Before,            //320x480         960×640
    iPhone5,                  //320x568         1136x640
    iPhoneSE,                 //320x568         1136x640
    iPhone6,                  //375x667         1334x750
    iPhone6P,                 //414x736         2208x1242(1920x1080)
    iPhone6s,                 //375x667         1334x750
    iPhone6sP,                //414x736         2208x1242(1920x1080)
    iPhone7,                  //375x667         1334x750
    iPhone7P,                 //414x736         2208x1242(1920x1080)
    iPhone8,                  //375x667         1334x750
    iPhone8P,                 //414x736         2208x1242(1920x1080)
    iPhoneX,                  //375x812         2436x1125
    iPhoneXS,                 //375x812         2436x1125
    iPhoneXSMax,              //414x896         2688x1242
    iPhoneXR,                 //414x896         828x1792
    iPad,                     //768x1024        1024x768
    iPad2,                    //768x1024        1024x768
    iPad3,                    //768x1024        2048x1536
    iPad4,                    //768x1024        2048x1536
    iPadAir,                  //768x1024        2048x1536
    iPadAir2,                 //768x1024        2048x1536
    iPadPro97,                //768x1024        2048x1536
    iPadPro129,               //1024x1336       2732x2048
    iPad5,                    //768x1024        2048x1536
    iPadPro129_2,             //1024x1336       2732x2048
    iPadPro105,               //834x1112        2224x1668
    iPadMini,                 //768x1024        768x1024
    iPadMini2,                //768x1024        2048x1536
    iPadMini3,                //768x1024        2048x1536
    iPadMini4,                //768x1024        2048x1536
    iTouch,                   //320x480         320x480
    iTouch2,                  //320x480         320x480
    iTouch3,                  //320x480         320x480
    iTouch4,                  //320x480         960x640
    iTouch5,                  //320x568         1136x640
    iTouch6,                  //320x568         1136x640
};

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Helpers)

/// 系统版本号
+ (double)systemVersion;

/// 是否是ipad
+ (BOOL)isPad;

/// 是否是iPhone
+ (BOOL)isPhone;

/// 是否是模拟器
+ (BOOL)isSimulator;

/// 是否可以打电话
+ (BOOL)canMakePhoneCalls;

/// wifi IP地址 例：@"192.168.1.111"
+ (NSString *)ipAddressWIFI;

/// 单元 IP地址 例：@"10.2.2.222"
+ (NSString *)ipAddressCell;

/// 当前设备型号
+ (DeviceModel)currectModel;

#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// 总磁盘空间（单位 byte） (-1为出错)
@property (nonatomic, readonly) int64_t diskSpace;

/// 剩余磁盘空间（单位 byte） (-1为出错)
@property (nonatomic, readonly) int64_t diskSpaceFree;

/// 已使用磁盘空间（单位 byte） (-1为出错)
@property (nonatomic, readonly) int64_t diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// 总内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
/// 已使用内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryUsed;

/// 剩余内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryFree;

/// 活动内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryActive;

/// 非活动内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryInactive;

/// 有线内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryWired;

/// 可清楚的内存（单位：byte） (-1为出错)
@property (nonatomic, readonly) int64_t memoryPurgable;

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// 可使用的cpu数量
@property (nonatomic, readonly) NSUInteger cpuCount;

/// 当前cpu使用率 1.0位100% (-1为出错)
@property (nonatomic, readonly) float cpuUsage;

/// 每个处理器的当前CPU使用率，1.0表示100% (nil为出错)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *cpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END


#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef kiOS12Later
#define kiOS12Later (kSystemVersion >= 12)
#endif
