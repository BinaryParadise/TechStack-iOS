//
//  NLTIRouterUIHelper.h
//  NLTIRouterAction
//
//  Created by Rake Yang on 2019/10/10.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Peregrine/Peregrine.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLTIRouterUIHelper : NSObject

+ (NSBundle *)resourceBundle;

@end

@interface UIColor (named)

+ (UIColor *)ti_background1;
+ (UIColor *)ti_background2;
+ (UIColor *)ti_section;
+ (UIColor *)ti_line1;
+ (UIColor *)ti_special;
+ (UIColor *)ti_white;

@end

NS_ASSUME_NONNULL_END
