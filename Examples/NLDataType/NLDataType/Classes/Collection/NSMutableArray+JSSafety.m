//
//  NSMutableArray+JSSafety.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NSMutableArray+JSSafety.h"

@implementation NSMutableArray (JSSafety)

- (id)js_objectAtIndex:(NSUInteger)index {
    return index < self.count ? [self objectAtIndex:index] : nil;
}

@end
