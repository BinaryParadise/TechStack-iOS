//
//  NLProtocolVersion.m
//  NLProtocols
//
//  Created by Rake Yang on 2019/12/4.
//

#import "NLModule.h"

@implementation NLModule

- (NSBundle *)resourceBundle {
    NSString *path = [NSString stringWithFormat:@"%@/%@.bundle", [NSBundle bundleForClass:self.class].bundlePath, NSStringFromClass(self.class)];
    return [NSBundle bundleWithPath:path];
}

@end
