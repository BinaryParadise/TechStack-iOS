//
//  MCJavaScriptAction.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/26.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "MCJavaScriptAction.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SNViewJSExport.h"

@implementation MCJavaScriptAction

+ (void)javaScriptCoreDemo1:(PGRouterContext *)context PGTarget("fd://JavaScriptCore/PrimitiveType") {
    JSContext *jsContext = [[JSContext alloc] init];
    JSValue *value = [jsContext evaluateScript:@"2+3"];
    DDLogDebug(@"2+3 = %d", [value toInt32]);
}

+ (void)scriptNative:(PGRouterContext *)context PGTarget("fd://JavaScriptCore/ScriptNative") {
    JSContext *jsContext = [[JSContext alloc] init];
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        MCLogError(@"%@", exception);
    };
    [jsContext evaluateScript:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Environment.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil]];
    jsContext[@"hellooc"] =  ^() {
        MCLogWarn(@"HelloWord");
    };
    jsContext[@"SNBridge"] = [[SNViewJSExport alloc] init];
    JSValue *retValue = [jsContext[@"demo"] callWithArguments:nil];
    [self pushViewController:retValue.toObject animated:YES];
}

@end
