//
//  NLTIRouterUIHelper.m
//  NLTIRouterAction
//
//  Created by Rake Yang on 2019/8/01.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLTIRouterUIHelper.h"
#import <MCUIKit/UIColor+MCExtension.h>

@implementation NLTIRouterUIHelper

+ (NSBundle *)resourceBundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingString:@"/NLTIRouterAction.bundle"]];
}

@end

@implementation UIColor (named)

+ (UIColor *)ti_colorNamed:(NSString *)name {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:name inBundle:[NLTIRouterUIHelper resourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

+ (UIColor *)ti_background1 {
    return [UIColor ti_colorNamed:@"TI_Background1"]?:MCHexColor(0xF6F6F6);
}

+ (UIColor *)ti_background2 {
    return [UIColor ti_colorNamed:@"TI_Background2"]?:MCHexColor(0xF6F6F6);
}

+ (UIColor *)ti_section {
    return [UIColor ti_colorNamed:@"TI_Section"]?:MCHexColor(0xF6F6F6);
}

+ (UIColor *)ti_line1 {
    return [UIColor ti_colorNamed:@"TI_Line1"]?:MCHexColor(0xC1C1C1);
}

+ (UIColor *)ti_special {
    return [UIColor ti_colorNamed:@"TI_Special"]?:MCHexColor(0x3C6188);
}

+ (UIColor *)ti_white {
    return [UIColor ti_colorNamed:@"TI_White"]?:[UIColor whiteColor];
}

@end
