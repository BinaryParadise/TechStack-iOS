//
//  GDInterfaceBuildAction.h
//  UIKitDemo
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDInterfaceBuildAction : TIRouterActionBase

+ (void)xibDemo:(PGRouterContext *)context PGTarget("gd://InterfaceBuild/Storyboard");

@end

NS_ASSUME_NONNULL_END
