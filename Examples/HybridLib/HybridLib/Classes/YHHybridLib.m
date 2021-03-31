//
//  YHHybridLib.m
//  HybridLib
//
//  Created by Rake Yang on 2021/3/17.
//

#import "YHHybridLib.h"
#import <WechatOpenSDK/WXApi.h>
#import "HybridLib-Swift.h"

@implementation YHHybridLib

+ (BOOL)verification {
    return [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}

@end
