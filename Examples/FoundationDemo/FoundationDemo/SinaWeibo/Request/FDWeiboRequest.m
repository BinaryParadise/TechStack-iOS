//
//  FDWeiboRequest.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDWeiboRequest.h"

@implementation FDWeiboRequest

+ (NSURL *)getParams:(NSString *)url params:(NSDictionary *)params {
    NSMutableString *mstr = [NSMutableString string];
    [mstr appendFormat:@"https://api.weibo.com/2/%@?", url];
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"];
    if (userinfo) {
        [mstr appendFormat:@"access_token=%@&", userinfo[@"access_token"]];
    }
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mstr appendFormat:@"%@=%@&", key, obj];
    }];
    return [NSURL URLWithString:mstr];
}

+ (void)getDataWithURL:(NSString *)url params:(NSDictionary *)params completion:(nonnull FDActionCompletion)completion {
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[self getParams:url params:params] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        BOOL success = [[dict objectForKey:@"error_code"] isEqualToString:@"0"] || !error;
        if (completion) {
            completion(success, dict, error);
        }
    }];
    [dataTask resume];
}

@end
