//
//  WJWebVC.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJWebVC : WJBaseVC

/**
 是否根据网页改变标题
 */
@property (nonatomic,assign) BOOL changeTitle;

/**
 是否pop到根页面
 */
@property (nonatomic,assign) BOOL isPopToRoot;

/**
 网页参数
 */
@property (nonatomic,strong) NSMutableDictionary *params;

/**
 添加网页地址
 */
-(void)addWebView:(NSString*) url;

/**
 加载本地html
 */
-(void)addHtmlWebView:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
