//
//  NLRouterActionProtocol.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLModuleServiceDefine.h"

/**
 路由表管理协议
 */
@protocol NLRouterActionProtocol <NLModuleService>

/**
 路由列表
 */
- (UIViewController *)mangerController;

/**
 打开路由

 @param URLString 地址
 @param completion 回调
 */
- (void)openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion;

@end
