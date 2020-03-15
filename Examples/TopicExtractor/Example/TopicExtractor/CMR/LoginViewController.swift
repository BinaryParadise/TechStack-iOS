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
        
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
//        let website = webView.configuration.websiteDataStore
        let cookies = HTTPCookieStorage.shared.cookies(for: URL.init(string: "http://cmr.com.cn")!)
        let url = "http://learning.cmr.com.cn"
        
        let request = URLRequest.init(url: URL.init(string: url)!)
        wkWebView.load(request)
    }
}

extension LoginViewController: WKUIDelegate {
    
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DDLogInfo("\(webView.url)")
    }
}
