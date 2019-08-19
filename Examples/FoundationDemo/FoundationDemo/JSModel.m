//
//  JSModel.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "JSModel.h"

@implementation JSModel

- (instancetype)initWithTag:(NSString *)tag {
    if (self = [super init]) {
        _tag = tag;
    }
    return self;
}

- (void)dealloc {
    MCLogWarn(@"%@ > %@", NSStringFromClass(self.class), self.tag);
}

@end
