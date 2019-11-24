//
//  FDCategoryAction.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDCategoryAction.h"
#import "TestModel1+FDAddition2.h"
#import "FDTestModel3.h"
#import "FDTM2.h"

@interface FDCategoryAction ()

- (void)classExtension;

@end

@implementation FDCategoryAction

+ (void)methodCover:(PGRouterContext *)context {
    [[FDTestModel3 alloc] testMethod];
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
