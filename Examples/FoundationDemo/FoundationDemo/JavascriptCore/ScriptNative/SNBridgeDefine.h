//
//  SNBridgeDefine.h
//  FoundationDemo
//
//  Created by Rakey Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavascriptCore/JavascriptCore.h>

@protocol SNJSExport <JSExport>

JSExportAs(__invoke,- (id)invoke:(NSDictionary *)typeInfo method:(NSString *)method arguments:(NSArray *)arguments);

@end

@protocol SNViewJSExport <JSExport>

@property (nonatomic, assign) BOOL ret;

- (UIView *)View:(NSDictionary *)dict;
- (UIViewController *)Controller:(NSDictionary *)dict;

@end
