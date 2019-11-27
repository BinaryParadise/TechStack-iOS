//
//  FDTM2.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/22.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDTM2.h"

@implementation FDTM2

+ (void)initialize {
    MCLogDebug(@"父类");
}

- (NSInteger)hello {
    MCLogDebug(@"");
    return 0;
}

@end

@implementation FDTM2 (Extra1)

+ (void)initialize {
    MCLogDebug(@"分类");
}

- (NSInteger)hello {
    MCLogDebug(@"");
    return 1;
}

@end

@implementation FDTM2 (Extra2)

+ (void)initialize {
    MCLogDebug(@"分类");
}

- (NSInteger)hello {
    MCLogDebug(@"");
    return 2;
}

@end

@implementation FDTM2Child1

+ (void)initialize {
    MCLogDebug(@"子类1，此处未实现时父类将多次调用");
}

@end

@implementation FDTM2Child2

+ (void)initialize {
    MCLogDebug(@"子类2");
}

@end
