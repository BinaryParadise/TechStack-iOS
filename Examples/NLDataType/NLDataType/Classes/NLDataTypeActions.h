//
//  NLDataTypeActions.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLDataTypeActions : NLRouterActionBase

PGMethod(constVariable, "fd://Foundation/DataType/Const");

@end

NS_ASSUME_NONNULL_END
