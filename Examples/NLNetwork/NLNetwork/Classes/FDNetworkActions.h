//
//  FDNetworkActions.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "TIRouterActionBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDNetworkActions : TIRouterActionBase

PGMethod(_SyncRef, "fd://Network/NSURLConnection/SyncRef?c=同步请求，传引用");
PGMethod(_SyncBlock, "fd://Network/NSURLConnection/SyncBlock?c=同步请求，block回调");
PGMethod(_CFNetwork, "fd://Network/CFNetwork");
PGMethod(_AFNetworking, "fd://Network/AFNetworking");
PGMethod(_URLSessionBlock, "fd://Network/URLSession/Block?c=使用Block回调");
PGMethod(_URLSessionDelegate, "fd://Network/URLSession/Delegate?c=使用Delegate回调，子线程");

@end

NS_ASSUME_NONNULL_END
