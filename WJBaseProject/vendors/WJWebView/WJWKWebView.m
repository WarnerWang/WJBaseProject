//
//  WJWKWebView.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJWKWebView.h"

//这里可以统一设置WebView的访问域名，方便切换
#ifdef DEBUG
#   define BASE_URL_API    @"http://****/"   //测试环境
#else
#   define BASE_URL_API    @"http://****/"   //正式环境
#endif

@interface WJWKWebView ()

@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation WJWKWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        
        if (configuration) {
            [configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];
        }
        
        //这句是关闭系统自带的侧滑后退（历史浏览记录）
        //        self.allowsBackForwardNavigationGestures = YES;
        self.baseUrl = [NSURL URLWithString:BASE_URL_API];
    }
    
    return self;
}

- (void)addScriptMessageHandlerWithMethodName:(NSString *)name{
    [self.configuration.userContentController addScriptMessageHandler:self name:name];
}

- (void)removeScriptMessageHandle:(NSString *)name{
    [self.configuration.userContentController removeScriptMessageHandlerForName:name];
}

#pragma mark - Load Url

- (void)loadRequestWithRelativeUrl:(NSString *)relativeUrl; {
    
    [self loadRequestWithRelativeUrl:relativeUrl params:nil];
}

- (void)loadRequestWithRelativeUrl:(NSString *)relativeUrl params:(NSDictionary *)params {
    
    NSURL *url = [self generateURL:relativeUrl params:params];
    
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

/**
 *  加载本地HTML页面
 *
 *  @param htmlName html页面文件名称
 */
- (void)loadLocalHTMLWithFileName:(nonnull NSString *)htmlName {
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:htmlName
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self loadHTMLString:htmlCont baseURL:baseURL];
}

- (NSURL *)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
    
    self.webViewRequestUrl = baseURL;
    self.webViewRequestParams = params;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSMutableArray* pairs = [NSMutableArray array];
    
    for (NSString* key in param.keyEnumerator) {
        NSString *value = [NSString stringWithFormat:@"%@",[param objectForKey:key]];
        
        NSString *charactersToEscape = @"!*'\"();:@&=+$,/?%#[]% ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *escaped_value = [value stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    
    NSString *query = [pairs componentsJoinedByString:@"&"];
    baseURL = [baseURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString* url = @"";
    if ([baseURL containsString:@"?"]) {
        url = [NSString stringWithFormat:@"%@&%@",baseURL, query];
    }
    else {
        url = [NSString stringWithFormat:@"%@?%@",baseURL, query];
    }
    //绝对地址
    if ([url.lowercaseString hasPrefix:@"http"]) {
        return [NSURL URLWithString:url];
    }
    else {
        return [NSURL URLWithString:url relativeToURL:self.baseUrl];
    }
}

/**
 *  重新加载webview
 */
- (void)reloadWebView {
    [self loadRequestWithRelativeUrl:self.webViewRequestUrl params:self.webViewRequestParams];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"message:%@",message.body);
    if ([message.body isKindOfClass:[NSDictionary class]]) {

        NSDictionary *body = (NSDictionary *)message.body;

        WJScriptMessage *msg = [WJScriptMessage new];
        [msg setValuesForKeysWithDictionary:body];

        if (self.wj_messageHandlerDelegate && [self.wj_messageHandlerDelegate respondsToSelector:@selector(wj_webView:didReceiveScriptMessage:)]) {
            [self.wj_messageHandlerDelegate wj_webView:self didReceiveScriptMessage:msg];
        }
    }else{
        WJScriptMessage *msg = [WJScriptMessage new];
        //    [msg setValuesForKeysWithDictionary:message];
        msg.method = message.name;
        msg.params = message.body;
        
        if (self.wj_messageHandlerDelegate && [self.wj_messageHandlerDelegate respondsToSelector:@selector(wj_webView:didReceiveScriptMessage:)]) {
            [self.wj_messageHandlerDelegate wj_webView:self didReceiveScriptMessage:msg];
        }
    }
    
    
    
}

#pragma mark - JS

- (void)callJS:(NSString *)jsMethod {
    [self callJS:jsMethod handler:nil];
}

- (void)callJS:(NSString *)jsMethod handler:(void (^)(id _Nullable))handler {
    
    NSLog(@"call js:%@",jsMethod);
    [self evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (handler) {
            handler(response);
        }
    }];
}

- (void)dealloc{
    [self.configuration.userContentController removeScriptMessageHandlerForName:@"webViewApp"];
}

@end
