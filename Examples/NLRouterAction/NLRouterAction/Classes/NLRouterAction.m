//
//  NLRouterAction.h
//  NLRouterAction
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLRouterAction.h"
#import "NLRouterActionVC.h"
#import <Peregrine/Peregrine.h>

@implementation NLRouterAction

- (UIViewController *)mangerController {
    return [[NLRouterActionVC alloc] initWithNibName:nil bundle:[self resourceBundle]];
}

- (void)openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion {
    [PGRouterManager openURL:URLString completion:completion];
}

@end
