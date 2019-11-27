//
//  NLFoundation.m
//  NLFoundation
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLFoundation.h"

@implementation NLFoundation

- (NSBundle *)resourceBundle {
    NSString *path = [NSString stringWithFormat:@"%@/%@.bundle", NSBundle.mainBundle.bundlePath, NSStringFromClass(self.class)];
    return [NSBundle bundleWithPath:path];
}

@end
