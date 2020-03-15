//
//  CustomURLProtocol2.swift
//  TopicExtractor_Example
//
//  Created by Rake Yang on 2020/3/15.
//  Copyright © 2020年 CocoaPods. All rights reserved.
//

import Foundation

class CustomURLProtocol2: URLProtocol {
    var connection:NSURLConnection?
    //url请求获取到的数据
    var receivedData: NSMutableData?
    
    override class func canInit(with request: URLRequest) -> Bool {
        //对于已处理过的请求则跳过，避免无限循环标签问题
        if URLProtocol.property(forKey: "WKURLProtocolHandledKey", in: request) != nil {
            return false
        }
        //只处理作业中心HomeworkCenter
        if request.httpMethod == "POST" {
            return true
        }
        return false
    }
    
    //规范化的请求（通常只要返回原来的请求就可以）
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //判断两个请求是否为同一个请求，如果为同一个请求那么就会使用缓存数据。
    //通常都是调用父类的该方法。我们也不许要特殊处理。
    override class func requestIsCacheEquivalent(_ aRequest: URLRequest,
                                                 to bRequest: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, to:bRequest)
    }
    
    //开始处理这个请求
    override func startLoading() {
        
        let newRequest = (self.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        //NSURLProtocol接口的setProperty()方法可以给URL请求添加自定义属性。
        //（这样把处理过的请求做个标记，下一次就不再处理了，避免无限循环请求）
        
        URLProtocol.setProperty(true, forKey: "WKURLProtocolHandledKey",
                                in: newRequest)
        
        //使用URLSession从网络获取数据
        connection = NSURLConnection.init(request: self.request, delegate: self)
    }
    
    //结束处理这个请求
    override func stopLoading() {
        self.connection?.cancel()
        self.connection = nil
        self.receivedData   = nil
    }
}

extension CustomURLProtocol2: NSURLConnectionDelegate {
    
}

extension CustomURLProtocol2: NSURLConnectionDataDelegate {
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        client?.urlProtocolDidFinishLoading(self)
    }
    
    // https证书验证
    func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge) {
        
    }
    
    func connection(_ connection: NSURLConnection, needNewBodyStream request: URLRequest) -> InputStream? {
        return request.httpBodyStream
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        self.client?.urlProtocol(self, didFailWithError: error)
    }
}
