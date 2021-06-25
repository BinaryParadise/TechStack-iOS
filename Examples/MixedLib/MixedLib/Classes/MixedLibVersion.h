//
//  MixedLibVersion.h
//  MixedLib
//
//  Created by Rake Yang on 2021/4/19.
//

#import <Foundation/Foundation.h>

#warning 无法通过Module导入混编的Pod库
//@import HybridLib;
#import <HybridLib/YHHybridLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface MixedLibVersion : NSObject

+ (BOOL)verification;

@end

NS_ASSUME_NONNULL_END
