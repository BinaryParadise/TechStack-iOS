//
//  NLJSModel.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLJSModel.h"

@implementation NLJSModel

- (instancetype)initWithTag:(NSString *)tag {
    if (self = [super init]) {
        _tag = tag;
    }
    return self;
}

- (void)dealloc {
    NLLogDebug(@"%@ > %@", NSStringFromClass(self.class), self.tag);
}

@end
