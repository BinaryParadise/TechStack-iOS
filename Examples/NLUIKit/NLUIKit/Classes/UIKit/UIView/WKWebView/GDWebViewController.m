//
//  WebViewController.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "GDWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <Masonry/Masonry.h>
#import "GDUIHelper.h"
#import <Peregrine/Peregrine.h>

@interface GDWebViewController () <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIWebView *uiWebView;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation GDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupWebView];
}

- (void)setupWebView {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"webview.html" ofType:nil];
    [self addCustomCookie];
    if (self.useWKWebview) {
        //属性设置
        WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];
        webViewConfig.preferences = [WKPreferences new];
        webViewConfig.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        webViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        //添加Cookie
        NSString *cookieStr = [NSMutableString stringWithFormat:@"document.cookie=\"%@=%@;path=/\";",@"fname", @"Rake Yang"];
        WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [webViewConfig.userContentController addUserScript:cookieScript];
        
        //注册自定义脚本
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:[NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"UserScript.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [webViewConfig.userContentController addUserScript:userScript];
        [webViewConfig.userContentController addScriptMessageHandler:self name:@"objc"];
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webViewConfig];
        self.wkWebView.UIDelegate = self;
        self.wkWebView.navigationDelegate = self;
        [self.view addSubview:self.wkWebView];
        [self.wkWebView loadRequest:[self requestWithPath:htmlPath]];
    } else {
        self.uiWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.uiWebView.delegate = self;
        [self.view addSubview:self.uiWebView];
        [self.uiWebView loadRequest:[self requestWithPath:htmlPath]];
    }
    
    UIButton *callJSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callJSButton.backgroundColor = [UIColor orangeColor];
    callJSButton.layer.cornerRadius = 5;
    [callJSButton setTitle:@"OC调用JS" forState:UIControlStateNormal];
    [callJSButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:callJSButton];
    [callJSButton addTarget:self action:@selector(callJSAction:) forControlEvents:UIControlEventTouchUpInside];
    [callJSButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@50);
        make.width.equalTo(self.view).multipliedBy(0.8);
        make.bottom.equalTo(self.view).offset(-8 - [GDUIHelper safeAreaBottom]);
    }];
}

- (NSMutableURLRequest *)requestWithPath:(NSString *)path {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    NSDictionary *headerFields = [NSHTTPCookie requestHeaderFieldsWithCookies:NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies];
    request.allHTTPHeaderFields = headerFields;
    return request;
}

#pragma mark - Actions

- (IBAction)callJSAction:(UIButton *)sender {
    NSString *jsCode = [NSString stringWithFormat:@"callJSFunc('%@')", [NSDate date]];
    if (self.useWKWebview) {
        [self.wkWebView evaluateJavaScript:jsCode completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
            if (error) {
                DDLogError(@"%@ %@", obj, error);
            } else {
                DDLogDebug(@"%@", obj);
            }
        }];
    } else {
        jsCode = [self.uiWebView stringByEvaluatingJavaScriptFromString:jsCode];
        DDLogDebug(@"%@", jsCode);
    }
}

- (void)addCustomCookie {
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{
                                                                NSHTTPCookieName: @"fname",
                                                                NSHTTPCookieDomain: @".apple.com",
                                                                NSHTTPCookiePath: @"/",
                                                                NSHTTPCookieValue: @"Rake Yang"
                                                                }];
    [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookie:cookie];
    [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //加载之前或者重定向的时候调用
    NLLogInfo(@"");
    if ([request.URL.absoluteString hasPrefix:@"mc://"]) {
        if ([request.URL.absoluteString isEqualToString:@"mc://1"]) {
            //调用JS方法
            NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"callJSFunc('来自JS的调用1!')"];
            NLLogWarn(@"结果：%@", result);
        } else if ([request.URL.absoluteString isEqualToString:@"mc://2"]) {
            NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"callJSFunc('来自OC的调用1!')"];
            NLLogWarn(@"结果：%@", result);
        } else if ([request.URL.absoluteString isEqualToString:@"mc://3"]) {
            JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
            [context[@"callJSFunc"] callWithArguments:@[@"来自OC的调用2!"]];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //开始加载时调用
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //加载完成时调用
    [webView stringByEvaluatingJavaScriptFromString:@"disableWKWebView()"];
    
    //获取该UIWebView的javascript上下文
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"callFromJS"] = ^(NSString *title) {
        self.title = title;
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //加载失败时调用
}

#pragma mark - WKnavigationDelegate

// 决定导航的动作，通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接
// 单独处理。但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 决定是否接收响应
// 这个是决定是否接收response
// 要获取response，通过WKNavigationResponse对象获取
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 当main frame的导航开始请求时，会调用此方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if ([PGRouterManager dryRun:webView.URL.absoluteString]) {
        [PGRouterManager openURL:webView.URL.absoluteString completion:nil];
    }
    NLLogDebug(@"%@", webView.URL.absoluteString);
}

// 当main frame接收到服务重定向时，会回调此方法
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 当main frame的web内容开始到达时，会回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

// 当main frame导航完成时，会回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [webView evaluateJavaScript:@"disableUIWebBtn('callFromOC1!')" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NLLogError(@"%@", error);
    }];
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

// 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

// 当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

#pragma mark - WKScriptMessageHandler

/**
 处理网页的调用请求

 @param userContentController 内容控制器
 @param message 脚本消息
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"objc"]) {
        NSNumber *tag = message.body;
        NLLogDebug(@"%@", message.body);
        if ([tag isEqual:@2]) {
            [message.webView evaluateJavaScript:@"callJSFunc('callFromOC2!')" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                DDLogInfo(@"%@", obj);
            }];
        } else if ([tag isEqual:@4]) {
            [message.webView evaluateJavaScript:@"callJSFunc('callFromOC3!')" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                DDLogInfo(@"%@", obj);
            }];
        }
    }
}

- (void)dealloc {
    NLLogInfo(@"");
}

@end
