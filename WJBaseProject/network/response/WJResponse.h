//
//  WJResponse.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJResponse : WJBaseModel

@property (nonatomic,copy) NSString* errMsg;
@property (nonatomic,copy) NSString* errCode;

@end

NS_ASSUME_NONNULL_END
