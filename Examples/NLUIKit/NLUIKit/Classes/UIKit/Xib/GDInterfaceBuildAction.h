//
//  GDInterfaceBuildAction.h
//  UIKitDemo
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NLRouterAction/NLRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDInterfaceBuildAction : NLRouterActionBase

PGMethod(xibDemo, "gd://InterfaceBuild/Storyboard")

@end

NS_ASSUME_NONNULL_END
