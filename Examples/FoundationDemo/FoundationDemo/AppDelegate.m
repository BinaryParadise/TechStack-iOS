//
//  AppDelegate.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/1/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "AppDelegate.h"
#import <TIRouterAction/TIRouterAction.h>
#import <MCLogger/MCLogger.h>

@interface testClass : NSObject

@property (nonatomic, strong) NSString *title;

@end

@implementation testClass

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initMCLogger];
    
    [PGRouterManager openURL:@"fd://weibo/init?appKey=3609616584" completion:^(BOOL ret, id object) {
        if (!ret) {
            DDLogError(@"%@", object);
        }
    }];
    
    return YES;
}

- (void)initMCLogger {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MCLogger startMonitor:[NSURL URLWithString:@"ws://172.16.106.113:8081"]];
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
    __block BOOL canOpen;
    [PGRouterManager openURL:@"fd://weibo/openurl" object:url completion:^(BOOL ret, id object) {
        canOpen = ret;
    }];
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self application:application openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication}];
}

@end
