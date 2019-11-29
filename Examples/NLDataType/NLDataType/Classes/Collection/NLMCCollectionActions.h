//
//  JSNSArrayViewController.h
//  Neverland
//
//  Created by Rake Yang on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterAction.h>

@interface NLMCCollectionActions : NLRouterActionBase

PGMethod(unsafeArray, "fd://Foundation/Collection/NSArray/unsafe?c=正常使用（不安全🔞）");
PGMethod(safeArray, "fd://Foundation/Collection/NSArray/safe?safe=1&c=安全使用");
PGMethod(uiDemo, "fd://Foundation/Collection/NSArray/UI?c=页面展示");

@end
