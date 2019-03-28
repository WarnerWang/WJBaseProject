//
//  WJWKWebView.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WJScriptMessage.h"

NS_ASSUME_NONNULL_BEGIN

@class WJWKWebView;
@class WJScriptMessage;

@protocol WJWKWebViewMessageHandleDelegate <NSObject>

@optional
- (void)wj_webView:(nonnull WJWKWebView *)webView didReceiveScriptMessage:(nonnull WJScriptMessage *)message;

@end

@interface WJWKWebView : WKWebView<WKScriptMessageHandler,WJWKWebViewMessageHandleDelegate>

//webview加载的url地址
@property (nullable, nonatomic, copy) NSString *webViewRequestUrl;
//webview加载的参数
@property (nullable, nonatomic, copy) NSDictionary *webViewRequestParams;

@property (nullable, nonatomic, weak) id<WJWKWebViewMessageHandleDelegate> wj_messageHandlerDelegate;

- (void)addScriptMessageHandlerWithMethodName:(nonnull NSString *)name;

- (void)removeScriptMessageHandle:(nonnull NSString *)name;

#pragma mark - Load Url

- (void)loadRequestWithRelativeUrl:(nonnull NSString *)relativeUrl;

- (void)loadRequestWithRelativeUrl:(nonnull NSString *)relativeUrl params:(nullable NSDictionary *)params;

/**
 *  加载本地HTML页面
 *
 *  @param htmlName html页面文件名称
 */
- (void)loadLocalHTMLWithFileName:(nonnull NSString *)htmlName;

#pragma mark - View Method

/**
 *  重新加载webview
 */
- (void)reloadWebView;

#pragma mark - JS Method Invoke

/**
 *  调用JS方法（无返回值）
 *
 *  @param jsMethod JS方法名称
 */
- (void)callJS:(nonnull NSString *)jsMethod;

/**
 *  调用JS方法（可处理返回值）
 *
 *  @param jsMethod JS方法名称
 *  @param handler  回调block
 */
- (void)callJS:(nonnull NSString *)jsMethod handler:(nullable void(^)(__nullable id response))handler;

@end

NS_ASSUME_NONNULL_END
