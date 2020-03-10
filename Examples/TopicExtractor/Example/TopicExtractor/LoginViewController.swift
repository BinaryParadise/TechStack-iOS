//
//  LoginViewController.swift
//  TopicExtractor_Example
//
//  Created by Rake Yang on 2020/3/8.
//  Copyright © 2020年 CocoaPods. All rights reserved.
//

import Cocoa
import WebKit
import CocoaLumberjack

class LoginViewController: NSViewController {
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        wkWebView.navigationDelegate = self
//        let website = webView.configuration.websiteDataStore
        let cookies = HTTPCookieStorage.shared.cookies(for: URL.init(string: "http://cmr.com.cn")!)
        let url = (cookies?.count)! > 100 ?"http://learning.cmr.com.cn/student/acourse/index.asp?clsid=bk134a":"http://learning.cmr.com.cn/"
        
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpShouldHandleCookies = true
        wkWebView.load(request)
        var count = UInt32()
        guard let properties = class_copyPropertyList(WKWebView.self, &count) else {return}
        for i in 0..<Int(count) {
            let property: objc_property_t = properties[i]
            DDLogDebug("\(String(describing: String.init(utf8String: property_getName(property))))")
        }
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
