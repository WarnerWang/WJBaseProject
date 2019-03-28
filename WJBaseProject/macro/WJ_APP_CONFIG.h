//
//  WJ_APP_CONFIG.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#ifndef WJ_APP_CONFIG_h
#define WJ_APP_CONFIG_h

// 是否是线上版本
#define IS_RELEASE 1
// 是否需要加密
#define DES_ENABLE YES
// 默认秘钥
#define DES_KEY @"hxsports"

#if IS_RELEASE

// ----------------------   正式环境配置参数  -------------------------
#define BASE_URL @""
#define DES_BASE_URL @""
#define UPLOAD_URL @""
#define DES_UPLOAD_URL @""

#else

// ----------------------   测试环境配置参数  -------------------------
#define BASE_URL @""
#define DES_BASE_URL @""
#define UPLOAD_URL @""
#define DES_UPLOAD_URL @""

#endif

#endif /* WJ_APP_CONFIG_h */
