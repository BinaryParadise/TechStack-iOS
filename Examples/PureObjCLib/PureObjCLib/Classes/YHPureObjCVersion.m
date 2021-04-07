//
//  YHPureObjCVersion.m
//  PureObjCLib
//
//  Created by Rake Yang on 2021/3/17.
//

#import "YHPureObjCVersion.h"
#import <WechatOpenSDK/WXApi.h>

@implementation YHPureObjCVersion

+ (BOOL)verification {    
    return [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}

@end
