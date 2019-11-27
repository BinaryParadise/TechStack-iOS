//
//  NLModuleService.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLModuleServiceDefine.h"
#import "NLRouterActionProtocol.h"
#import "NLFoundationProtocol.h"

#define NLM_RouterAction    NLModuleForProtocol(NLRouterActionProtocol)
#define NLM_Foundation      NLModuleForProtocol(NLFoundationProtocol)

/**
 提供模块相关服务
 */
@interface NLModuleService : NSObject

- (void)registerModule:(id<NLModuleService>)module forProtocol:(Protocol *)protocol;

- (id)moduleForProtocol:(Protocol *)protocol;

@end
