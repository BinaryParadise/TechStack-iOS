//
//  NSInvocation+ScriptNative.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NSInvocation+ScriptNative.h"
#import <objc/runtime.h>
#import "NSDictionary+ScriptNative.h"

@implementation NSInvocation (ScriptNative)

- (void)setArgumentWithObject:(id)obj atIndex:(NSUInteger)index {
    const char *argType = [self.methodSignature getArgumentTypeAtIndex:index];
    if (strncmp(@encode(long), argType, 1) == 0) {
        long value = [(NSNumber *)obj longValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(CGRect), argType, 1) == 0) {
        NSDictionary *dict = obj;
        CGRect value = CGRectMake([dict sn_doubleForKey:@"x"], [dict sn_doubleForKey:@"y"], [dict sn_doubleForKey:@"width"], [dict sn_doubleForKey:@"height"]);
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(id), argType, 1) == 0) {
        id value = obj;
        [self setArgument:&value atIndex:index];
    }
    else {
        void *value;
        [self setArgument:&value atIndex:index];
    }
}

@end
