//
//  NLModuleService.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterActionBase.h>

/**
 框架组件
 */
@interface NLDesignPatternsActions : NLRouterActionBase

PGMethod(simpleFactory, "fd://Extension/设计模式/创建型/简单工厂模式");
PGMethod(factoryFunction, "fd://Extension/设计模式/创建型/工厂方法模式");

@end
