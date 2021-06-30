//
//  AppDelegate.swift
//  BeSwifter
//
//  Created by Rake Yang on 02/19/2021.
//  Copyright (c) 2021 Rake Yang. All rights reserved.
//

import UIKit
import Canary

class SwiftLogFormatter: NSObject, DDLogFormatter {
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(logMessage.timestamp) \(logMessage.fileName).\(logMessage.function ?? "")+\(logMessage.line) \(logMessage.message)"
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configCanary()
        DDTTYLogger.sharedInstance?.logFormatter = SwiftLogFormatter()
        DDLog.add(DDTTYLogger.sharedInstance!)
        return true
    }
    
    func configCanary() {
        CanarySwift.shared.deviceId = "1c1984ee-d986-11eb-b8bc-0242ac130003"
        CanarySwift.shared.appSecret = "fbc8714f459c771348e2de0ac7bac3d6"
        CanarySwift.shared.baseURL = "http://127.0.0.1:10048"
        DDLog.sharedInstance.add(CanaryTTYLogger())
        CanarySwift.shared.startLogger()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

class CanaryTTYLogger: DDAbstractLogger {
    override func log(message logMessage: DDLogMessage) {
        CanarySwift.shared.storeLogMessage(dict: logMessage.dictionaryWithValues(forKeys: CanarySwift.StoreLogKeys), timestamp: logMessage.timestamp.timeIntervalSince1970)
    }
}
