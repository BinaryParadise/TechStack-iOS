//
//  NSInvocation+ScriptNative.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (ScriptNative)

- (void)setArgumentWithObject:(id)obj atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
