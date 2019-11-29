//
//  NLRouterActionProtocol.h
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLProtocolDefine.h"

/**
 新浪微博协议
 */
@protocol NLWeiboProtocol <NLModuleService>

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
