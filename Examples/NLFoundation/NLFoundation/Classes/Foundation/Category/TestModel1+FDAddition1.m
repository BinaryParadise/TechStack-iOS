//
//  TestModel1+Addition1.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/10.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "TestModel1+FDAddition1.h"
#import <objc/runtime.h>

static void *exstensionKey = &exstensionKey;

@implementation NLTestModel1 (FDAddition1)

+ (void)load {
    NSLog(@"%s +%d 分类", __FUNCTION__, __LINE__);
}

- (NSString *)exstension {
    return objc_getAssociatedObject(self, exstensionKey);
}

- (void)setExstension:(NSString *)exstension {
    objc_setAssociatedObject(self, exstensionKey, exstension, OBJC_ASSOCIATION_COPY);
}

- (void)testMethod {
    MCLogWarn(@"覆盖方法");
}

@end
