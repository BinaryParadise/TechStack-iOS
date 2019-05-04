//
//  TestClass.h
//  ClangDemo
//
//  Created by joengzi on 2019/5/3.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Receiver(title) __attribute__((objc_ioc_inject(title)))
#define Action(title)

Receiver("星际之门")
__attribute__((objc_runtime_name("86d3cd67eed8590114cbfc3c8ab1d374")))
@interface TestClass : NSObject

+ (void)registerGroup:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
