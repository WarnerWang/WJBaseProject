//
//  WJPageRequest.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/27.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJPageRequest : WJRequest

@property (nonatomic,assign) NSInteger from;//开始页码
@property (nonatomic,assign) NSInteger size;//数量

@end

NS_ASSUME_NONNULL_END
