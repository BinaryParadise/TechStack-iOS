//
//  GDBaseAction.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Peregrine/Peregrine.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDBaseAction : NSObject

+ (NSString *)storyBoardName;

+ (UIViewController *)controllerForIdentify:(NSString *)identify;

+ (void)pushViewControllerWithIdentify:(NSString *)identify;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
