//
//  MixedLibVersion.m
//  MixedLib
//
//  Created by Rake Yang on 2021/4/19.
//

#import "MixedLibVersion.h"
//#import <MixedLib/MixedLib-Swift.h>
#import "MixedLib-Swift.h"
#import <HybridLib/YHHybridLib.h>
//@import lib_objectivec; //Could not build Objective-C module 'lib_objectivec'
@import LibObjectivec;
@import LibSwifter;

@implementation MixedLibVersion

+ (BOOL)verification {
    return [YHHybridLib verification]
    && [MixedLibSwift verification]
    && [LOFactory verify]
    && [LibSwifterVersion verify]
    ;
}

@end
