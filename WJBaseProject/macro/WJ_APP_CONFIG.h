//
//  WJ_APP_CONFIG.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/25.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#ifndef WJ_APP_CONFIG_h
#define WJ_APP_CONFIG_h

#import "WJApiHostHelper.h"

// 接口地址
#define BASE_URL [WJApiHostHelper getBaseUrl]
#define DES_BASE_URL [WJApiHostHelper getBaseUrl]
// 上传接口地址
#define DES_UPLOAD_URL [WJApiHostHelper getUploadUrl]
#define UPLOAD_URL [WJApiHostHelper getUploadUrl]

#endif /* WJ_APP_CONFIG_h */
