//
//  GDUIHelper.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/11/18.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDUIHelper.h"

@implementation GDUIHelper

+ (CGFloat)safeAreaBottom {    
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return 0;
}

@end
