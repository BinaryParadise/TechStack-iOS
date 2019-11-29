//
//  NLMCFloatNumberActions
//  Neverland
//
//  Created by Rake Yang on 2019/1/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterAction.h>

/**
 浮点数
 */
@interface NLMCFloatNumberActions : NLRouterActionBase

PGMethod(processFloat, "fd://Foundation/DataType/Float");

@end
