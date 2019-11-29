//
//  FDWeiboRequest.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLFWBRequestManager.h"
#import <MCJSONKit/MCJSONKit.h>

@implementation NLFWBRequestManager

+ (NSURL *)getParams:(NSString *)url params:(NSDictionary *)params {
    NSMutableString *mstr = [NSMutableString string];
    if ([url hasPrefix:@"http"]) {
        [mstr appendFormat:@"%@?", url];
    } else {
        [mstr appendFormat:@"https://api.weibo.com/2/%@?", url];
    }
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"];
    if (userinfo) {
        [mstr appendFormat:@"access_token=%@&", userinfo[@"access_token"]];
    }
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mstr appendFormat:@"%@=%@&", key, obj];
    }];
    return [NSURL URLWithString:[mstr substringToIndex:mstr.length-1]];
}

+ (void)getDataWithURL:(NSString *)url params:(NSDictionary *)params completion:(nonnull FDActionCompletion)completion {
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[self getParams:url params:params] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (completion) {
            if (!error && [dict isKindOfClass:[NSDictionary class]] && [dict mc_intForKey:@"error_code"] != 0) {
                error =  [NSError errorWithDomain:@"api.weibo.com" code:[dict mc_intForKey:@"error_code"] userInfo:@{NSLocalizedDescriptionKey: dict[@"error"]?:@"unknown"}];
            }
            completion(dict, error);
        }
    }];
    [dataTask resume];
}

@end
