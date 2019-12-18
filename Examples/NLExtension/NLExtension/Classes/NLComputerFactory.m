//
//  NLComputerFactory.m
//  NLExtension
//
//  Created by Rake Yang on 2019/12/3.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLComputerFactory.h"
#import <NLModelService/NLLaptop.h>
#import <NLModelService/NLDesktop.h>

@implementation NLComputerFactory

+ (NLComputer *)createWithType:(NLComputerType)type {
    switch (type) {
        case NLComputerTypeDesktop:
            return [NLDesktop new];
        default:
            return [NLLaptop new];
    }
}

@end
