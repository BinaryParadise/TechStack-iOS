//
//  NLCategoryAction.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLCategoryAction.h"
#import "TestModel1+FDAddition2.h"
#import "NLTestModel3.h"
#import "NLTM2.h"

@interface NLCategoryAction ()

- (void)classExtension;

@end

@implementation NLCategoryAction

+ (void)methodCover:(PGRouterContext *)context {
    [[NLTestModel3 alloc] testMethod];
    [context finished];
}

+ (void)loadMethod:(PGRouterContext *)context {
    [self methodCover:context];
}

+ (void)initializeMethod:(PGRouterContext *)context {
    NSAssert([[FDTM2Child2 alloc] hello] == 2, @"应该是2");
    [context finished];
}

@end
