//
//  GDUIViewAction.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDUIViewAction : NLRouterActionBase

PGMethod(viewLifecycleAction, "gd://UIView/Lifecycle?c=生命周期");

PGMethod(uiWebViewAction, "gd://UIView/WebView/UIWebView");

PGMethod(wkWebViewAction, "gd://UIView/WebView/WKWebView?wkwebview=1");

PGMethod(labelDemo, "gd://UIView/UILabelInset");

PGMethod(entrance, "gd://UIView/entrance?c=总入口");

@end

NS_ASSUME_NONNULL_END
