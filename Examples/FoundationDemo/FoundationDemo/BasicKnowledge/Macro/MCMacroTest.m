//
//  MCMacroTest.m
//  FoundationDemo
//
//  Created by joengzi on 2019/4/16.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "MCMacroTest.h"
#import "MCMacroDefine1.h"
#import "MCMacroDefine3.h"
#import "MCMacroDefine2.h"

@implementation MCMacroTest

- (instancetype)init {
    if (self = [super init]) {
        //宏定义已寸在时以最后导入的定义为准
        int i = kMCMacroTestValue;
        MCLogDebug(@"%d", i);
    }
    return self;
}

@end
