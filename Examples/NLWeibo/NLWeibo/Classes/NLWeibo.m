//
//  NLWeibo.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/11/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLWeibo.h"
#import <Weibo_SDK/WeiboSDK.h>

@interface NLWeibo () <WeiboSDKDelegate>

@end

@implementation NLWeibo

- (NSBundle *)resourceBundle {
    NSString *path = [NSString stringWithFormat:@"%@/%@.bundle", NSBundle.mainBundle.bundlePath, NSStringFromClass(self.class)];
    return [NSBundle bundleWithPath:path];
}

+ (void)initialize {
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    BOOL ret = [WeiboSDK registerApp:@"3609616584"];
    NLLogWarn(@"微博SDK注册结果: %@", ret?@"成功":@"失败");
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:response.userInfo forKey:@"weibo_sso_data"];
        }
    } else {
        NLLogError(@"%@", response.userInfo);
    }
}

@end
