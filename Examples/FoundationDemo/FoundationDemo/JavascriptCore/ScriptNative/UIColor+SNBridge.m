//
//  UIColor+SNBridge.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "UIColor+SNBridge.h"

@implementation UIColor (SNBridge)

+ (UIColor *)colorWithHex:(long)hexColor {
    CGFloat red = ((hexColor & 0xFF0000) >> 16);
    CGFloat green = ((hexColor & 0x00FF00) >> 8);
    CGFloat blue = ((hexColor & 0x00FF) >> 0);
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

@end
