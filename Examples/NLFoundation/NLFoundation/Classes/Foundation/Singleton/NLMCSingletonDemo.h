//
//  NLMCSingletonDemo.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/3/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLMCSingletonDemo : NSObject

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
