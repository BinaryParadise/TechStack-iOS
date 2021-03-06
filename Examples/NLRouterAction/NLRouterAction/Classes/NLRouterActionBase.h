//
//  NLRouterActionBase.h
//  NLRouterAction
//
//  Created by Rake Yang on 2019/8/01.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Peregrine/Peregrine.h>
#import <MCJSONKit/MCJSONKit.h>
#import <NLModuleService/NLModuleService.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLRouterActionBase : NSObject

+ (NSString *)storyBoardName;

+ (UIViewController *)controllerForIdentify:(NSString *)identify;

+ (void)pushViewControllerWithIdentify:(NSString *)identify;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
