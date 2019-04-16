//
//  MCMacroTest.m
//  FoundationDemo
//
//  Created by joengzi on 2019/4/16.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "MCMacroTest.h"
#import "MCMacroDefine1.h"
#import "MCMacroDefine3.h"
#import "MCMacroDefine2.h"

@implementation MCMacroTest

- (instancetype)init {
    if (self = [super init]) {
#warning The macro definition has been valid at the time of the last imported definition!
        //宏定义已在时最后导入的定义有效
        int i = kMCMacroTestValue;
    }
    return self;
}

@end
