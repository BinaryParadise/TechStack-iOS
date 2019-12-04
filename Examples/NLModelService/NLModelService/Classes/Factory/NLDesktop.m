//
//  NLDesktop.m
//  NLModelService
//
//  Created by Rake Yang on 2019/12/3.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLDesktop.h"
#import "NLAMD.h"
#import "NLIntel.h"
#import "NLApple.h"
#import "NLLenovo.h"

@implementation NLDesktop

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.brand = [NLApple new];
        self.cpu = [NLIntel new];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@,%@", [self class], self, self.brand, self.cpu];
}

@end
