//
//  NLMCMacroTest.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/4/16.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLMCMacroTest.h"
#import "NLMCMacroDefine1.h"
#import "NLMCMacroDefine3.h"
#import "NLMCMacroDefine2.h"

@implementation NLMCMacroTest

- (instancetype)init {
    if (self = [super init]) {
        //宏定义已寸在时以最后导入的定义为准
        int i = kMCMacroTestValue;
        MCLogDebug(@"%d", i);
    }
    return self;
}

@end
