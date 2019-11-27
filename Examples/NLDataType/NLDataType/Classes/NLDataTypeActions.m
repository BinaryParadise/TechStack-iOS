//
//  NLDataTypeActions.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLDataTypeActions.h"

const int   *p1;
int const   *p2;
int const   p3 = 30;
const int   p4 = 40;//等价于p3
const  int   * const p; //p和*p都只读

//static修饰后外部无法访问
NSString * const kTestKey1 = @"https://www.apple.com.cn";
static NSString const * kTestKey2 = @"https://www.apple.com.cn";
FOUNDATION_EXTERN NSString * const KTestKey3 = @"xxxxx";

@implementation NLDataTypeActions

+ (void)constVariable:(PGRouterContext *)context {
    NLLogWarn(@"const右边无法更改");
    int a = 99;
    p1 = &a;
    //*p1 = 10; 无法修改
    
    p2 = &a;
    //*p2 = 20; 无法修改
    
    //p3 = 30; 无法修改
    
//    p4 = 40;
    
    //kTestKey1 = @"https://www.apple.com"; 无法修改
    kTestKey2 = @"https://www.apple.com";
    
    NLLogDebug(@"p1=%d p2=%d p3=%d, key=%@", *p1, *p2, p3, kTestKey2);
    
    [context finished];
}

@end
