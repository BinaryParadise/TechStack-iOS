//
//  AppDelegate.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "AppDelegate.h"
#import <MCLogger/MCLogger.h>
#import <TIRouterAction/TIRouterAction.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MCLogger startMonitor:[NSURL URLWithString:@"ws://172.16.106.113:8081"]];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TIRouterActionManager mangerController]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    DDLogVerbose(@"");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    DDLogVerbose(@"");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    DDLogVerbose(@"");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    DDLogVerbose(@"");
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        ASAuthorizationAppleIDProvider *provider = [ASAuthorizationAppleIDProvider new];
        NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"appleid_user"];
        [provider getCredentialStateForUserID:user completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
            switch (credentialState) {
                case ASAuthorizationAppleIDProviderCredentialAuthorized:
                    LogWarn(@"授权状态有效");
                    break;
                case ASAuthorizationAppleIDProviderCredentialNotFound:
                    LogWarn(@"授权凭证缺失（可能是使用AppleID 登录过App）");
                    break;
                case ASAuthorizationAppleIDProviderCredentialRevoked:
                    LogWarn(@"上次使用苹果账号登录的凭据已被移除，需解除绑定并重新引导用户使用苹果登录");
                    break;
                default:
                    LogWarn(@"未知状态");break;
            }

            if (error) {
                LogError(@"%@", error);
            }
        }];    
#endif
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DDLogVerbose(@"");
}


@end
