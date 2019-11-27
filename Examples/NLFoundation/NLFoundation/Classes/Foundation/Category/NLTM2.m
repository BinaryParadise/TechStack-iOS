//
//  NLTM2.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/22.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLTM2.h"

@implementation NLTM2

+ (void)initialize {
    NLLogDebug(@"父类");
}

- (NSInteger)hello {
    NLLogDebug(@"");
    return 0;
}

@end

@implementation NLTM2 (Extra1)

+ (void)initialize {
    NLLogDebug(@"分类");
}

- (NSInteger)hello {
    NLLogDebug(@"");
    return 1;
}

@end

@implementation NLTM2 (Extra2)

+ (void)initialize {
    NLLogDebug(@"分类");
}

- (NSInteger)hello {
    NLLogDebug(@"");
    return 2;
}

@end

@implementation FDTM2Child1

+ (void)initialize {
    NLLogDebug(@"子类1，此处未实现时父类将多次调用");
}

@end

@implementation FDTM2Child2

+ (void)initialize {
    NLLogDebug(@"子类2");
}

@end
