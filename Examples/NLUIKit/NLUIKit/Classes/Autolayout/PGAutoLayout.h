//
//  PGAutolayout.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/15.
//  Copyright © 2019 joengzi. All rights reserved.
//

#import <NLRouterAction/NLRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGAutoLayout : NLRouterActionBase

PGMethod(equalization, "gd://UIView/Equalization")

PGMethod(scrollView, "gd://AutoLayout/UIScrollView")

@end

NS_ASSUME_NONNULL_END
