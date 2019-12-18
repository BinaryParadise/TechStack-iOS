//
//  NLExtension.m
//  NLExtension
//
//  Created by Rake Yang on 2019/12/03.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLExtension.h"
#import <NLProtocols/NLExtensionProtocol.h>

@interface NLExtension () <NLExtensionProtocol>

@end

@implementation NLExtension

- (NSBundle *)resourceBundle {
    NSString *path = [NSString stringWithFormat:@"%@/%@.bundle", NSBundle.mainBundle.bundlePath, NSStringFromClass(self.class)];
    return [NSBundle bundleWithPath:path];
}

@end
