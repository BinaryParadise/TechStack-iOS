//
//  FDBasicActions.h
//  FoundationDemo
//
//  Created by lingjing on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDBasicActions : TIRouterActionBase

+ (void)kvoDemo:(PGRouterContext *)context PGTarget("fd://Basic/KVO");

+ (void)kvcDemo:(PGRouterContext *)context PGTarget("fd://Basic/KVC");

@end

NS_ASSUME_NONNULL_END
