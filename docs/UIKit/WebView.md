# UIWebView

```objc
//加载方法
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
```

```objc
//执行JavaScript脚本【由于是同步的，需在主线程】
- (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
```

### *UIWebViewDelegate*

```objc
//是否可加载指定的网页，常用来和JS交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
```
```objc
//开始加载时调用
- (void)webViewDidStartLoad:(UIWebView *)webView;
```
```objc
//加载完成时调用
- (void)webViewDidFinishLoad:(UIWebView *)webView;
```
```objc
//加载失败时调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
```

### OC调用JS

##### 1、[JavaScriptCore](../JavaScriptCore.md)（iOS 7.0引入)

```objc
JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
JSValue *value = [context evaluateScript:@"document.title"];
self.title = value.toString;
```

##### 2、调用`stringByEvaluatingJavaScriptFromString`

### JS调用OC

##### 1、`JavaScriptCore`

##### 2、`shouldStartLoadWithRequest`拦截

### Cookie

> 使用`NSHTTPCookieStorage`管理

- 添加到Header中
```objc
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.LynkCo.com"]];
   [request addValue:@"cookitnmae=78965420;" forHTTPHeaderField:@"Set-Cookie"];
   [self.webView loadRequest:request];

- 自定义Cookie
```objc
NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{
    NSHTTPCookieName: @"fname",
    NSHTTPCookieDomain: @".neverland.com",
    NSHTTPCookiePath: @"/"
    NSHTTPCookieValue: @"1234567890",
}];
//Cookie存在则覆盖，不存在添加
[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
```
- 读取所有Cookie，Cookie转换成HTTPHeaderFields，并添加到request的header中
```objc
NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
//Cookies数组转换为requestHeaderFields
NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//设置请求头
request.allHTTPHeaderFields = requestHeaderFields;
```

## WKWebView
### *包含14个类和3个协议*
名称 | 说明
---- | ----
WKBackForwardList | 之前访问过的 web 页面的列表，可以通过后退和前进动作来访问到。
WKBackForwardListItem | webview 中后退列表里的某一个网页。
WKFrameInfo | 包含一个网页的布局信息。
WKNavigation | 包含一个网页的加载进度信息。
WKNavigationAction | 包含可能让网页导航变化的信息，用于判断是否做出导航变化。
WKNavigationResponse | 包含可能让网页导航变化的返回内容信息，用于判断是否做出导航变化。
WKPreferences | 概括一个 webview 的偏好设置。
WKProcessPool | 表示一个 web 内容加载池。
WKUserContentController |  提供使用 JavaScript post 信息和注射 script 的方法。
WKScriptMessage | 包含网页发出的信息。
WKUserScript | 表示可以被网页接受的用户脚本。
WKWebViewConfiguration | 初始化 webview 的设置。
WKWindowFeatures | 指定加载新网页时的窗口属性。
WKWebsiteDataStore | 包含网页数据存储和查找。
[WKNavigationDelegate](#awknavdelegate) | 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
WKUIDelegate | 提供用原生控件显示网页的方法回调。
WKScriptMessageHandler | 提供从网页中收消息的回调方法。

### 初始化示例

```objc
//属性设置
WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];
webViewConfig.preferences = [WKPreferences new];
webViewConfig.preferences.javaScriptEnabled = YES;
//不通过用户交互，是否可以打开窗口
webViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;

//添加Cookie
NSString *cookieStr = [NSMutableString stringWithFormat:@"document.cookie='%@=%@;path=/';",@"fname", @"Rake Yang"];
WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
[webViewConfig.userContentController addUserScript:cookieScript];

//注册自定义脚本
WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
[webViewConfig.userContentController addUserScript:userScript];
[webViewConfig.userContentController addScriptMessageHandler:self name:@"objc"];

self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webViewConfig];
self.wkWebView.UIDelegate = self;
self.wkWebView.navigationDelegate = self;
[self.view addSubview:self.wkWebView];
[self.wkWebView loadRequest:[self requestWithPath:htmlPath]];
```

### <a name="awknavdelegate"><a>WKNavigationDelegate

加载过程相关

```objc
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
```

页面跳转相关

```objc
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
```

### WKScriptMessageHandler

用于native与网页端的交互

```objc
// 网页中调用脚本是调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
```
### Cookie

通过脚本注入添加
```js
document.cookie="fname=Rake Yang;path=/";
```
