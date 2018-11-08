//
//  WebViewController.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController () <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) BOOL useWKWebview;
@property (nonatomic, strong) UIWebView *uiWebView;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否使用WKWebView?" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.useWKWebview = YES;
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"webview.html" ofType:nil];
    if (self.useWKWebview) {
        //属性设置
        WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];
        webViewConfig.preferences = [WKPreferences new];
        webViewConfig.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        webViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        //注册自定义脚本
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [webViewConfig.userContentController addUserScript:userScript];
        [webViewConfig.userContentController addScriptMessageHandler:self name:@"objc"];
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webViewConfig];
        self.wkWebView.UIDelegate = self;
        self.wkWebView.navigationDelegate = self;
        [self.view addSubview:self.wkWebView];
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    }else {
        self.uiWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.uiWebView.delegate = self;
        [self.view addSubview:self.uiWebView];
        [self.uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //加载之前或者重定向的时候调用
    LogInfo(@"");
    if ([request.URL.absoluteString hasPrefix:@"mc://"]) {
        LogWarn(@"来自JS的调用");
        if ([request.URL.absoluteString isEqualToString:@"mc://1"]) {
            //调用JS方法
            NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"callJSFunc('来自OC的调用!')"];
            LogWarn(@"结果：%@", result);
            LogError(@"不是真的发生Error只是为了演示效果!");
        }else {
            self.title = @"标题被JS代码修改了哦!";
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
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //加载失败时调用
}

#pragma mark - WKnavigationDelegate

// 决定导航的动作，通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接
// 单独处理。但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
}

// 决定是否接收响应
// 这个是决定是否接收response
// 要获取response，通过WKNavigationResponse对象获取
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
}

// 当main frame的导航开始请求时，会调用此方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
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
    
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

// 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    
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
    
}

- (void)dealloc {
    LogInfo(@"");
}

@end
