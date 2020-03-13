//
//  TopicAdapter.swift
//  TopicExtractor_Example
//
//  Created by Rake Yang on 2020/3/8.
//  Copyright © 2020年 CocoaPods. All rights reserved.
//

import Cocoa
import Alamofire

class TopicAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        request.httpShouldHandleCookies = true
        if request.url?.host == nil {
            request.url = URL.init(string: "http://learning.cmr.com.cn"+(urlRequest.url?.absoluteString)!)
        }
        // SetCookies
        return request
    }
}
