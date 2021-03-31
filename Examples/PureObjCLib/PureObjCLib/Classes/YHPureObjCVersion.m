//
//  YHPureObjCVersion.m
//  PureObjCLib
//
//  Created by Rake Yang on 2021/3/17.
//

#import "YHPureObjCVersion.h"
#import <WechatOpenSDK/WXApi.h>
@import SwiftPodLib;

@implementation YHPureObjCVersion

+ (BOOL)verification {    
    return [SwiftPodLib verification] && [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}

@end
