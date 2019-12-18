//
//  NLComputerFactory.h
//  NLExtension
//
//  Created by Rake Yang on 2019/12/3.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NLModelService/NLModelService.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    NLComputerTypeDesktop   = 0,
    NLComputerTypeLaptop    = 1,
} NLComputerType;

@interface NLComputerFactory : NSObject

+ (NLComputer *)createWithType:(NLComputerType)type;

@end

NS_ASSUME_NONNULL_END
