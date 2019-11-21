//
//  FDCategoryAction.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDCategoryAction.h"
#import "TestModel1+FDAddition1.h"
#import "TestModel1+FDAddition2.h"

@implementation FDCategoryAction

+ (void)methodCover:(PGRouterContext *)context {
    [[TestModel1 alloc] testMethod];
    [context finished];
}

+ (void)loadMethod:(PGRouterContext *)context {
    MCLogDebug(@"");
}

+ (void)initializeMethod:(PGRouterContext *)context {
    
}

@end
