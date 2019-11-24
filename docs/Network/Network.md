# 网络



## NSURLConnection

已过时，苹果建议使用NSURLSession

```objc
//立即请求
- (instancetype)initWithRequest:(NSURLRequest *)request delegate:(nullable id)delegate;

//同步请求
+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse *)response error:(NSError **)error;

//同步请求，block回调
+ (void)sendAsynchronousRequest:(NSURLRequest*)request
                          queue:(NSOperationQueue*)queue
              completionHandler:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError)) handler;
```



## NSURLSession

详见Demo

## AFNetworking

详见Demo

## CFNetworking

C语言编写的底层网络框架，详见Demo