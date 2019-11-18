//
//  GDUIViewAction.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface GDUIViewAction : TIRouterActionBase

PGMethod(viewLifecycleAction, "gd://UIView/Lifecycle?c=生命周期");

PGMethod(uiWebViewAction, "gd://UIView/WebView/UIWebView");

PGMethod(wkWebViewAction, "gd://UIView/WebView/WKWebView?wkwebview=1");

PGMethod(labelDemo, "gd://UIView/UILabelInset");

@end

NS_ASSUME_NONNULL_END
