//
//  RNBridgeModule.m
//  WBReactNative
//
//  Created by Rake Yang on 2019/12/13.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "RNBridgeModule.h"
#import <UIKit/UIKit.h>

@implementation RNBridgeModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(dismiss) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *curVC = rootVC;
        if (rootVC.presentedViewController) {
            curVC = rootVC.presentedViewController;
        }
        [curVC dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
