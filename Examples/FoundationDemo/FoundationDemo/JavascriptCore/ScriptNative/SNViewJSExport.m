//
//  SNViewJSExport.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "SNViewJSExport.h"

@interface SNViewJSExport ()

@end

@implementation SNViewJSExport

+ (BOOL)ret {
    return YES;
}

- (SNViewController *)controller {
    return [[SNViewController alloc] init];
}

- (SNView *)view {
    return [[SNView alloc] init];
}

@end
