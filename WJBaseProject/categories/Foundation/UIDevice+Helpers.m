//
//  UIDevice+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "UIDevice+Helpers.h"
#import <sys/utsname.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <mach/mach.h>
#include <sys/sysctl.h>

@implementation UIDevice (Helpers)

+ (double)systemVersion {
    static double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}

+ (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

+ (BOOL)isPhone {
    static dispatch_once_t one;
    static BOOL iphone;
    dispatch_once(&one, ^{
        iphone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    });
    return iphone;
}

+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
+ (BOOL)canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}
#endif

+ (DeviceModel)currectModel{
    static DeviceModel deviceModel = UnKnown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *phoneModel = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
        //@"Apple#iPhone 1G"
        if ([phoneModel isEqualToString:@"iPhone1,1"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 3G"
        if ([phoneModel isEqualToString:@"iPhone1,2"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 3GS"
        if ([phoneModel isEqualToString:@"iPhone2,1"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 4"
        if ([phoneModel isEqualToString:@"iPhone3,1"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 4 Verizon"
        if ([phoneModel isEqualToString:@"iPhone3,2"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 4S"
        if ([phoneModel isEqualToString:@"iPhone4,1"])    deviceModel = iPhone4Before;
        //@"Apple#iPhone 5"
        if ([phoneModel isEqualToString:@"iPhone5,2"])    deviceModel = iPhone5;
        //@"Apple#iPhone 5c"
        if ([phoneModel isEqualToString:@"iPhone5,3"])    deviceModel = iPhone5;
        //@"Apple#iPhone 5c"
        if ([phoneModel isEqualToString:@"iPhone5,4"])    deviceModel = iPhone5;
        //@"Apple#iPhone 5s"
        if ([phoneModel isEqualToString:@"iPhone6,1"])    deviceModel = iPhone5;
        //@"Apple#iPhone 5s"
        if ([phoneModel isEqualToString:@"iPhone6,2"])    deviceModel = iPhone5;
        //@"Apple#iPhone 6 Plus"
        if ([phoneModel isEqualToString:@"iPhone7,1"])    deviceModel = iPhone6P;
        //@"Apple#iPhone 6"
        if ([phoneModel isEqualToString:@"iPhone7,2"])    deviceModel = iPhone6;
        //@"Apple#iPhone 6s"
        if ([phoneModel isEqualToString:@"iPhone8,1"])    deviceModel = iPhone6s;
        //@"Apple#iPhone 6s Plus"
        if ([phoneModel isEqualToString:@"iPhone8,2"])    deviceModel = iPhone6sP;
        //@"Apple#iPhone SE"
        if ([phoneModel isEqualToString:@"iPhone8,4"])    deviceModel = iPhoneSE;
        //@"Apple#iPhone 7"
        if ([phoneModel isEqualToString:@"iPhone9,1"])    deviceModel = iPhone7;
        //@"Apple#iPhone 7 Plus"
        if ([phoneModel isEqualToString:@"iPhone9,2"])    deviceModel = iPhone7P;
        //@"Apple#iPhone 7"
        if ([phoneModel isEqualToString:@"iPhone9,3"])    deviceModel = iPhone7;
        //@"Apple#iPhone 7 Plus"
        if ([phoneModel isEqualToString:@"iPhone9,4"])    deviceModel = iPhone7P;
        //@"Apple#iPhone 8 Global"
        if ([phoneModel isEqualToString:@"iPhone10,1"])   deviceModel = iPhone8;
        //@"Apple#iPhone 8 Plus Global"
        if ([phoneModel isEqualToString:@"iPhone10,2"])   deviceModel = iPhone8P;
        //@"Apple#iPhone X Global"
        if ([phoneModel isEqualToString:@"iPhone10,3"])   deviceModel = iPhoneX;
        //@"Apple#iPhone 8 GSM"
        if ([phoneModel isEqualToString:@"iPhone10,4"])   deviceModel = iPhone8;
        //@"Apple#iPhone 8 Plus GSM"
        if ([phoneModel isEqualToString:@"iPhone10,5"])   deviceModel = iPhone8P;
        //@"Apple#iPhone X GSM"
        if ([phoneModel isEqualToString:@"iPhone10,6"])   deviceModel = iPhoneX;
        
        //@"Apple#iPhone XS"
        if ([phoneModel isEqualToString:@"iPhone11,2"])   deviceModel = iPhoneXS;
        //@"Apple#iPhone XS Max (China)"
        if ([phoneModel isEqualToString:@"iPhone11,4"])   deviceModel = iPhoneXSMax;
        //@"Apple#iPhone XS Max"
        if ([phoneModel isEqualToString:@"iPhone11,6"])   deviceModel = iPhoneXSMax;
        //@"Apple#iPhone XR"
        if ([phoneModel isEqualToString:@"iPhone11,8"])   deviceModel = iPhoneXR;
        
        //@"Apple#Simulator 32"
        if ([phoneModel isEqualToString:@"i386"])         deviceModel = Simulator;
        //@"Apple#Simulator 64"
        if ([phoneModel isEqualToString:@"x86_64"])       deviceModel = Simulator;
        
        //@"iPad"
        if ([phoneModel isEqualToString:@"iPad1,1"]) deviceModel = iPad;
        //@"iPad 2"
        if ([phoneModel isEqualToString:@"iPad2,1"] ||
            [phoneModel isEqualToString:@"iPad2,2"] ||
            [phoneModel isEqualToString:@"iPad2,3"] ||
            [phoneModel isEqualToString:@"iPad2,4"]) deviceModel = iPad2;
        //@"iPad 3"
        if ([phoneModel isEqualToString:@"iPad3,1"] ||
            [phoneModel isEqualToString:@"iPad3,2"] ||
            [phoneModel isEqualToString:@"iPad3,3"]) deviceModel = iPad3;
        //@"iPad 4"
        if ([phoneModel isEqualToString:@"iPad3,4"] ||
            [phoneModel isEqualToString:@"iPad3,5"] ||
            [phoneModel isEqualToString:@"iPad3,6"]) deviceModel = iPad4;
        //@"iPad Air"
        if ([phoneModel isEqualToString:@"iPad4,1"] ||
            [phoneModel isEqualToString:@"iPad4,2"] ||
            [phoneModel isEqualToString:@"iPad4,3"]) deviceModel = iPadAir;
        //@"iPad Air 2"
        if ([phoneModel isEqualToString:@"iPad5,3"] ||
            [phoneModel isEqualToString:@"iPad5,4"]) deviceModel = iPadAir2;
        //@"iPad Pro 9.7-inch"
        if ([phoneModel isEqualToString:@"iPad6,3"] ||
            [phoneModel isEqualToString:@"iPad6,4"]) deviceModel = iPadPro97;
        //@"iPad Pro 12.9-inch"
        if ([phoneModel isEqualToString:@"iPad6,7"] ||
            [phoneModel isEqualToString:@"iPad6,8"]) deviceModel = iPadPro129;
        //@"iPad 5"
        if ([phoneModel isEqualToString:@"iPad6,11"] ||
            [phoneModel isEqualToString:@"iPad6,12"]) deviceModel = iPad5;
        //@"iPad Pro 12.9-inch 2"
        if ([phoneModel isEqualToString:@"iPad7,1"] ||
            [phoneModel isEqualToString:@"iPad7,2"]) deviceModel = iPadPro129_2;
        //@"iPad Pro 10.5-inch"
        if ([phoneModel isEqualToString:@"iPad7,3"] ||
            [phoneModel isEqualToString:@"iPad7,4"]) deviceModel = iPadPro105;
        
        //@"iPad mini"
        if ([phoneModel isEqualToString:@"iPad2,5"] ||
            [phoneModel isEqualToString:@"iPad2,6"] ||
            [phoneModel isEqualToString:@"iPad2,7"]) deviceModel = iPadMini;
        //@"iPad mini 2"
        if ([phoneModel isEqualToString:@"iPad4,4"] ||
            [phoneModel isEqualToString:@"iPad4,5"] ||
            [phoneModel isEqualToString:@"iPad4,6"]) deviceModel = iPadMini2;
        //@"iPad mini 3"
        if ([phoneModel isEqualToString:@"iPad4,7"] ||
            [phoneModel isEqualToString:@"iPad4,8"] ||
            [phoneModel isEqualToString:@"iPad4,9"]) deviceModel = iPadMini3;
        //@"iPad mini 4"
        if ([phoneModel isEqualToString:@"iPad5,1"] ||
            [phoneModel isEqualToString:@"iPad5,2"]) deviceModel = iPadMini4;
        
        //@"iTouch"
        if ([phoneModel isEqualToString:@"iPod1,1"]) deviceModel = iTouch;
        //@"iTouch2"
        if ([phoneModel isEqualToString:@"iPod2,1"]) deviceModel = iTouch2;
        //@"iTouch3"
        if ([phoneModel isEqualToString:@"iPod3,1"]) deviceModel = iTouch3;
        //@"iTouch4"
        if ([phoneModel isEqualToString:@"iPod4,1"]) deviceModel = iTouch4;
        //@"iTouch5"
        if ([phoneModel isEqualToString:@"iPod5,1"]) deviceModel = iTouch5;
        //@"iTouch6"
        if ([phoneModel isEqualToString:@"iPod7,1"]) deviceModel = iTouch6;
    });
    return deviceModel;
}



+ (NSString *)ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET: { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    } break;
                        
                    case AF_INET6: { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

+ (NSString *)ipAddressWIFI {
    return [self ipAddressWithIfaName:@"en0"];
}

+ (NSString *)ipAddressCell {
    return [self ipAddressWithIfaName:@"pdp_ip0"];
}

- (int64_t)diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceUsed {
    int64_t total = self.diskSpace;
    int64_t free = self.diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)memoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (int64_t)memoryUsed {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

- (int64_t)memoryFree {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

- (int64_t)memoryActive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

- (int64_t)memoryInactive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.inactive_count * page_size;
}

- (int64_t)memoryWired {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.wire_count * page_size;
}

- (int64_t)memoryPurgable {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.purgeable_count * page_size;
}

- (NSUInteger)cpuCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

- (float)cpuUsage {
    float cpu = 0;
    NSArray *cpus = [self cpuUsagePerProcessor];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

- (NSArray *)cpuUsagePerProcessor {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

@end
