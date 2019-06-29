//
//  MCJavaScriptAction.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/26.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "MCJavaScriptAction.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SNViewJSExportImpl.h"

@implementation MCJavaScriptAction

+ (void)javaScriptCoreDemo1:(PGRouterContext *)context PGTarget("fd://JavaScriptCore/PrimitiveType") {
    JSContext *jsContext = [[JSContext alloc] init];
    JSValue *value = [jsContext evaluateScript:@"2+3"];
    DDLogDebug(@"2+3 = %d", [value toInt32]);
}

+ (void)scriptNative:(PGRouterContext *)context PGTarget("fd://JavaScriptCore/ScriptNative") {
    static NSString *_regexStr = @"(?<!\\\\)\\.\\s*(\\w+)\\s*\\(";
    static NSString *_replaceStr = @".__c(\"$1\")(";
    NSRegularExpression* _regex;
    NSString *jsEngine = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SNEngine.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Environment.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    _regex = [NSRegularExpression regularExpressionWithPattern:_regexStr options:0 error:nil];
    jsContent = [_regex stringByReplacingMatchesInString:jsContent options:0 range:NSMakeRange(0, jsContent.length) withTemplate:_replaceStr];
    
    JSContext *jsContext = [[JSContext alloc] initWithVirtualMachine:[JSVirtualMachine new]];
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        MCLogError(@"%@", exception);
    };    
    jsContext[@"SNBridge"] = [[SNJSExportImpl alloc] init];
    [jsContext evaluateScript:[jsEngine stringByAppendingString:jsContent]];
    jsContext[@"hellooc"] =  ^() {
        MCLogWarn(@"HelloWord");
    };
    JSValue *retValue = [jsContext[@"demo"] callWithArguments:nil];
    [self pushViewController:retValue.toObject animated:YES];
}

@end
