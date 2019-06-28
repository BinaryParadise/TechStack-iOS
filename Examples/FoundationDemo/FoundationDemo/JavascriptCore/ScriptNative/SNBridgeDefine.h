//
//  SNBridgeDefine.h
//  FoundationDemo
//
//  Created by Rakey Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <JavascriptCore/JavascriptCore.h>

@class SNView, SNViewController;

@protocol SNJSExport <JSExport>

JSExportAs(new, - (instancetype)initWithDictionary:(NSDictionary *)dict);

@end

@protocol SNViewJSExport <NSObject>

+ (BOOL)ret;
- (SNView *)view;
- (SNViewController *)controller;

@end
