//
//  AppDelegate.m
//  WBReactNative
//
//  Created by Rake Yang on 2019/12/12.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "AppDelegate.h"
#import <NLModuleService/NLModuleService.h>
#import <NLWeibo/NLWeibo.h>
#import <NLLogger/NLLogger.h>
#import <SDWebImage/SDWebImage.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NLModuleService.new registerModule:[NLLoggerModule new] forProtocol:@protocol(NLLoggerProtocol)];
    [NLModuleService.new registerModule:[NLWeibo new] forProtocol:@protocol(NLWeiboProtocol)];
    
    //磁盘缓存文件最大字节数
    SDImageCacheConfig.defaultCacheConfig.maxDiskSize = 1024 * 1024;
    //内存最大缓存字节数
    SDImageCacheConfig.defaultCacheConfig.maxMemoryCost = 1024 * 1024 * 1;
    //内存最大缓存图片数
//    SDImageCacheConfig.defaultCacheConfig.maxMemoryCount = 32;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [NLM_Weibo application:app openURL:url options:options];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self application:application openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication}];
}

@end
