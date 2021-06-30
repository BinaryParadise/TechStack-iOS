//
//  WKWebViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/6/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import WebKit
import Peregrine
import JavaScriptCore

let kMessageHandlerKey  = "native"
let kNativeCallback = "nativeCallBack"

class WKWebViewController: ContentViewController {
    var wkWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let conf = WKWebViewConfiguration()
        if #available(iOS 14.0, *) {
            conf.userContentController.addScriptMessageHandler(self, contentWorld: .defaultClient, name: "native")
        } else {
            conf.userContentController.add(self, name: "native")
        }
        conf.userContentController.addUserScript(WKUserScript(source: try! String(contentsOfFile: Bundle.main.path(forResource: "bridging.js", ofType: nil)!), injectionTime: .atDocumentStart, forMainFrameOnly: false))
        wkWebView = WKWebView(frame: .zero, configuration: conf)
        if let wkWebView = wkWebView {
            wkWebView.navigationDelegate = self
            wkWebView.uiDelegate = self
            view.addSubview(wkWebView)
            wkWebView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            wkWebView.loadFileURL(URL(fileURLWithPath: Bundle.main.path(forResource: "enter.html", ofType: nil)!), allowingReadAccessTo: Bundle.main.bundleURL)
        }
        
        updateNaviBar()
    }
    
    func updateNaviBar() {
        var bars = [UIBarButtonItem(image: UIImage(named: "ic_nav_arrowleft"), style: .plain, target: self, action: #selector(onBackButton(sender:)))]
        if wkWebView.canGoBack {
            bars.append(UIBarButtonItem(image: UIImage(named: "ic_nav_close"), style: .plain, target: self, action: #selector(onCloseButton)))
        }
        navigationItem.leftBarButtonItems = bars
        
        wkWebView.evaluateJavaScript("document.title") { [weak self] (data, error) in
            self?.title = data as? String
        }
    }
    
    @objc override func onBackButton(sender: UIButton) {
        if wkWebView.canGoBack {
            wkWebView?.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func onCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func callbackFromNative(object: Any?) {
        var funccall = "\(kNativeCallback)()"
        if let object = object {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
                funccall = "\(kNativeCallback)(\(jsonData.string(encoding: .utf8) ?? ""))"
            } catch {
                DDLogInfo("\(error)")
            }
        }
        wkWebView?.evaluateJavaScript(funccall, completionHandler: { (data, error) in
            DDLogInfo("\(String(describing: error))")
        })
    }
}



extension WKWebViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandlerWithReply, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateNaviBar()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.scheme == "swift" {
            RouteManager.openURL(navigationAction.request.url?.absoluteString ?? "")
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        if message.name == kMessageHandlerKey {
            RouteManager.openURL(message.body as! String) { [weak self] ret, data in
                self?.callbackFromNative(object: data)
            }
        }
    }
        
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == kMessageHandlerKey {
            if let url = message.body as? String {
                if let u = URL(string: url) {
                    if u.pathComponents[1] == "timestamp" {
                        callbackFromNative(object: SwifterJSExport.timestamp)
                    }
                } else {
                    DDLogError("URL格式错误：\(url)")
                }
            }
        }
    }
    
}

extension WKWebViewController {
    @available(*, renamed: "route", message: "swift://wkwebview/noraml")
    @objc static func operationDemo(context: RouteContext) -> Void {
        pushViewController(controller: WKWebViewController())
    }
}
