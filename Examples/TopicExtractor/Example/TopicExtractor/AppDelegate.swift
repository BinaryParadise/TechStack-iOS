//
//  AppDelegate.swift
//  TopicExtractor
//
//  Created by rakeyang on 03/08/2020.
//  Copyright (c) 2020 rakeyang. All rights reserved.
//

import Cocoa
import MCFrontendKit
import Alamofire
import CocoaLumberjack

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    MCFrontendKit.manager()?.appKey = "com.binaryparadise.neverland"
    MCFrontendKit.manager()?.baseURL = URL.init(string: "http://frontend.xinc818.com/api/full");
    MCFrontendKit.manager()?.enableDebug = true
    MCFrontendKit.manager()?.startLogMonitor({ () -> [String : String]? in
        return [:]
    });
    
    print("sandbox: \(NSHomeDirectory())")
    
    Alamofire.SessionManager.default.adapter = TopicAdapter();
//    CMRCustomURLProtocol.register()
//    URLProtocol.registerClass(CustomURLProtocol2.self)
//    URLProtocol.registerClass(CMRCustomURLProtocol.self)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

