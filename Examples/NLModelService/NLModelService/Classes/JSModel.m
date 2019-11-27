//
//  JSModel.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/19.
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
    MCLogDebug(@"%@ > %@", NSStringFromClass(self.class), self.tag);
}

@end
