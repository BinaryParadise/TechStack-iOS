//
//  NLModuleService.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NLProtocols/NLProtocols.h>

#define NLModuleForProtocol(protocolName) ((id<protocolName>)[NLModuleService.new moduleForProtocol:@protocol(protocolName)])

#define NLM_RouterAction    NLModuleForProtocol(NLRouterActionProtocol)
#define NLM_Foundation      NLModuleForProtocol(NLFoundationProtocol)
#define NLM_Weibo           NLModuleForProtocol(NLWeiboProtocol)
#define NLM_Extension       NLModuleForProtocol(NLExtensionProtocol)

/**
 提供模块相关服务
 */
@interface NLModuleService : NSObject

- (void)registerModule:(id<NLModuleService>)module forProtocol:(Protocol *)protocol;

- (id)moduleForProtocol:(Protocol *)protocol;

@end
