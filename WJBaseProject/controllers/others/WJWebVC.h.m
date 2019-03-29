//
//  WJWebVC.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJWebVC.h"
#import "WJWKWebView.h"
#import "NSString+Helpers.h"
#import "WJUtils.h"
#import "WJ_MEASURE.h"

@interface WJWebVC ()<WKUIDelegate, WKNavigationDelegate,WJWKWebViewMessageHandleDelegate>

@property (nonatomic,copy) NSString* url;
@property (nonatomic,copy) NSString* localHtmlName;
@property (nonatomic,copy) WJWKWebView* webView;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation WJWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self initProgressView];
    [self addObservers];
}

- (void)addObservers{
    //添加观察者,观察wkwebview的estimatedProgress属性
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.changeTitle) {
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    if (!self.params) {
        self.params = [[NSMutableDictionary alloc]init];
    }
    [self.params setValue:@"1" forKey:@"source"];
    [self.params setValue:[NSString appVersion] forKey:@"version"];
    if ([WJUtils isLogin]) {
        
//        BCUserBean *userBean = [BCDataHelper getSavedUserBean];
//        [self.params setValue:userBean.userId forKey:@"userId"];
//        [self.params setValue:userBean.token forKey:@"token"];
//        [self.params setValue:userBean.secretKey forKey:@"secret"];
    }
    
    if (self.url) {
        
        [self.webView loadRequestWithRelativeUrl:self.url params:self.params];
    }
    
    if (self.localHtmlName) {
        [self.webView loadLocalHTMLWithFileName:self.localHtmlName];
    }
}


- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [[NSMutableDictionary alloc]init];
    }
    return _params;
}


- (void)initProgressView{
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, kNavHeight, self.view.frame.size.width, 2)];
    _progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:_progressView];
}

- (void)addWebView:(NSString *)url{
    if ([NSString isEmpty:url]) {
        return;
    }
    self.url = url;
    
}

- (void)popVC{
    if (_isPopToRoot) {
        [self popToRootVC];
    }else {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
            
            //            [self.webView reloadWebView];
            if ([self.title isEqualToString:@"订单详情"]) {
                [self.webView reload];
            }
        }else{
            [super popVC];
        }
    }
    
}

- (void)addHtmlWebView:(NSString *)name{
    if ([NSString isEmpty:name]) {
        return;
    }
    self.localHtmlName = name;
    
    if (self.webView) {
        [self.webView loadLocalHTMLWithFileName:self.localHtmlName];
    }
    
}

- (void)setupWebView {
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    CGFloat topHeight = kNavHeight + 1;
    _webView = [[WJWKWebView alloc]initWithFrame:CGRectMake(0, topHeight, self.view.frame.size.width, self.view.frame.size.height - topHeight) configuration:config];
    _webView.wj_messageHandlerDelegate = self;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    [self.view addSubview:_webView];
    
    
    [self addJSFuncName:config];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            if ([self changeTitle]) {
                self.title = self.webView.title;
            }
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    
}




/**
 注册与JS交互的方法名
 
 @param config WKWebView配置对象
 */
- (void)addJSFuncName:(WKWebViewConfiguration *)config{
//    [self.webView addScriptMessageHandlerWithMethodName:@""];
}

/**
 *  JS调用原生方法处理
 */
- (void)wj_webView:(WJWKWebView *)webView didReceiveScriptMessage:(WJScriptMessage *)message{
    
    if ([message.method isEqualToString:@""]) {
        
    }
}


#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"URL: %@", navigationAction.request.URL.absoluteString);
    
    
    UIApplication *app = [UIApplication sharedApplication];
    if ([webView.URL.scheme isEqualToString:@"tel"]){
        if ([app canOpenURL:webView.URL]){
            [app openURL:webView.URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([webView.URL.absoluteString containsString:@"itunes.apple.com"]){
        if ([app canOpenURL:webView.URL]){
            [app openURL:webView.URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKUIDelegate

/**
 *  处理js里的alert
 *
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  处理js里的confirm
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSString *)valueForParam:(NSString *)param inUrl:(NSURL *)url {
    
    NSArray *queryArray = [url.query componentsSeparatedByString:@"&"];
    for (NSString *params in queryArray) {
        NSArray *temp = [params componentsSeparatedByString:@"="];
        if ([[temp firstObject] isEqualToString:param]) {
            return [temp lastObject];
        }
    }
    return @"";
}

- (NSMutableDictionary *)paramsOfUrl:(NSURL *)url {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    NSArray *queryArray = [url.query componentsSeparatedByString:@"&"];
    for (NSString *params in queryArray) {
        NSArray *temp = [params componentsSeparatedByString:@"="];
        NSString *key = [temp firstObject];
        NSString *value = temp.count == 2 ? [temp lastObject]:@"";
        [paramDict setObject:value forKey:key];
    }
    return paramDict;
}

- (NSString *)stringByJoinUrlParams:(NSDictionary *)params {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in params.allKeys) {
        [arr addObject:[NSString stringWithFormat:@"%@=%@",key,params[key]]];
    }
    return [arr componentsJoinedByString:@"&"];
}

- (NSString *)urlWithoutQuery:(NSURL *)url {
    NSRange range = [url.absoluteString rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        return [url.absoluteString substringToIndex:range.location];
    }
    return url.absoluteString;
}


- (void)dealloc{
    if (self.changeTitle) {
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
