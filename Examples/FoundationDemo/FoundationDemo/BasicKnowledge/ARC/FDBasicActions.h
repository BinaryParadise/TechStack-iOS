//
//  FDBasicActions.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDBasicActions : TIRouterActionBase

PGMethod(kvoDemo, "fd://Basic/KVO");

PGMethod(kvcDemo, "fd://Basic/KVC");

@end

NS_ASSUME_NONNULL_END
