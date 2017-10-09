//
//  NSNumber+Addition.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "NSNumber+Addition.h"
#import <objc/runtime.h>

static void *centNumberKey = &centNumberKey;

@implementation NSNumber (Addition)

//@dynamic centNumber;

- (NSString *)centNumber {
    id obj = objc_getAssociatedObject(self, centNumberKey);
    return obj;
}

- (void)setCentNumber:(NSString *)centNumber {
    objc_setAssociatedObject(self, centNumberKey, centNumber, OBJC_ASSOCIATION_COPY);
}

@end
