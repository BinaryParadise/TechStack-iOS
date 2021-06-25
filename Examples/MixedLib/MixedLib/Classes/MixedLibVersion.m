//
//  MixedLibVersion.m
//  MixedLib
//
//  Created by Rake Yang on 2021/4/19.
//

#import "MixedLibVersion.h"
//#import <MixedLib/MixedLib-Swift.h> 仅限framework有效
#import "MixedLib-Swift.h"

@implementation MixedLibVersion

+ (BOOL)verification {
    return [YHHybridLib verification]
    && [MixedLibSwift verification]
    ;
}

@end
