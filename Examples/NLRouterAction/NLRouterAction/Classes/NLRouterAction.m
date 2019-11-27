//
//  NLRouterAction.h
//  NLRouterAction
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLRouterAction.h"
#import "NLRouterActionVC.h"

@implementation NLRouterAction

- (NSBundle *)resourceBundle {
    NSString *path = [NSString stringWithFormat:@"%@/%@.bundle", NSBundle.mainBundle.bundlePath, NSStringFromClass(self.class)];
    return [NSBundle bundleWithPath:path];
}

- (UIViewController *)mangerController {
    return [[NLRouterActionVC alloc] initWithNibName:nil bundle:nil];
}

@end
