//
//  NLComputer.h
//  NLModelService
//
//  Created by Rake Yang on 2019/12/3.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLBrand.h"
#import "NLCPU.h"

NS_ASSUME_NONNULL_BEGIN

@interface NLComputer : NSObject

@property (nonatomic, strong) NLBrand *brand;
@property (nonatomic, strong) NLCPU *cpu;

@end

NS_ASSUME_NONNULL_END
