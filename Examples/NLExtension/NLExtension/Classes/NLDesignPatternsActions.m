//
//  NLFoundation.m
//  NLFoundation
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLDesignPatternsActions.h"
#import "NLComputerFactory.h"

@implementation NLDesignPatternsActions

+ (void)simpleFactory:(PGRouterContext *)context {
    NLComputer *computer = [NLComputerFactory createWithType:NLComputerTypeDesktop];
    NLLogDebug(@"%@", computer);
    [context finished];
}

+ (void)factoryFunction:(PGRouterContext *)context {
    
}

@end
