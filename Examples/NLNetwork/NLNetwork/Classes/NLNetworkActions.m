//
//  NLNetworkActions.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLNetworkActions.h"
#import <AFNetworking/AFNetworking.h>
#import <CFNetwork/CFNetwork.h>

NSString * const kRequestURL = @"http://2000019.ip138.com";

@interface NLNetworkActions () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSURLConnectionDownloadDelegate, NSURLSessionDataDelegate>

@end

@implementation NLNetworkActions

NSString * subStrData(NSData *data) {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]您的IP地址是：\\S+\\s+\\S+\\s+\\S+[\\s\\S]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [re matchesInString:str options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, str.length)].lastObject;
    return [str substringWithRange:result.range];
}

+ (void)_SyncRef:(PGRouterContext *)context {
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kRequestURL]] returningResponse:&response error:&error];
    MCLogDebug(@"%@", subStrData(data));
    [context finished];
}

+ (void)_SyncBlock:(PGRouterContext *)context {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kRequestURL]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        MCLogDebug(@"%@", subStrData(data));
        [context finished];
    }];
}

+ (void)_CFNetwork:(PGRouterContext *)context {
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, (__bridge CFStringRef)kRequestURL, NULL);
    CFHTTPMessageRef request = CFHTTPMessageCreateRequest(kCFAllocatorDefault, CFSTR("GET"), myURL, kCFHTTPVersion1_1);
    //CFHTTPMessageSetBody(request, NULL);
    //CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Content-Type"), CFSTR("application/json"));
    CFReadStreamRef readStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, request);
    CFStreamClientContext ctx = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFReadStreamSetClient(readStream, kCFStreamEventHasBytesAvailable|kCFStreamEventEndEncountered|kCFStreamEventOpenCompleted|kCFStreamEventCanAcceptBytes|kCFStreamEventErrorOccurred, cfCallback, &ctx);
    CFReadStreamScheduleWithRunLoop(readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFReadStreamOpen(readStream);
    [context finished];
}

void cfCallback (CFReadStreamRef stream,CFStreamEventType type,void *clientCallBackInfo) {
    //流中有可读数据的回调
    if (type == kCFStreamEventHasBytesAvailable) {
        //将流中的数据存入到数组中
        UInt8 buff [10240];
        CFIndex index = CFReadStreamRead(stream, buff, 10240);
        printf("%s",buff);
        MCLogDebug(@"%@", subStrData([NSData dataWithBytes:buff length:index]));
    } else if(type==kCFStreamEventEndEncountered){
        //关闭流
        CFReadStreamClose(stream);
        //将流从runloop中移除
        CFReadStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    }
}

+ (void)_AFNetworking:(PGRouterContext *)context {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:kRequestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MCLogDebug(@"%@", subStrData(responseObject));
        [context finished];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MCLogError(@"%@", error);
        [context onDone:NO object:nil];
    }];
    
    [manager POST:kRequestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MCLogDebug(@"POST:%@", subStrData(responseObject));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

+ (void)_URLSessionBlock:(PGRouterContext *)context {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:kRequestURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        MCLogDebug(@"%@", subStrData(data));
        [context finished];
    }];
    [task resume];
}

+ (void)_URLSessionDelegate:(PGRouterContext *)context {
    static NLNetworkActions *delegate;
    delegate = [NLNetworkActions new];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:delegate delegateQueue:[NSOperationQueue new]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:kRequestURL]];
    [task resume];
    [context finished];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    MCLogWarn(@"");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    MCLogDebug(@"%@", subStrData(data));
}

@end
