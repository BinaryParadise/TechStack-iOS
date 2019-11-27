//
//  NLModuleService.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NLModuleForProtocol(protocolName) ((id<protocolName>)[NLModuleService.new moduleForProtocol:@protocol(protocolName)])

/**
 模块协议
 */
@protocol NLModuleService <NSObject>

/**
 资源包
 */
- (NSBundle *)resourceBundle;

@end
