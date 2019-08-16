//
//  AppDelegate.m
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "AppDelegate.h"
#import <MCLogger/MCLogger.h>
#import <TIRouterAction/TIRouterAction.h>

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
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TIRouterActionManager mangerController]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)initMCLogger {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MCLogger startMonitor:[NSURL URLWithString:@"ws://172.16.76.111:8081"]];
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


@end
