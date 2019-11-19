//
//  JSNSArrayViewController.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

@interface MCCollectionActions : TIRouterActionBase

PGMethod(unsafeArray, "fd://Collection/NSArray/unsafe?c=正常使用（不安全🔞）");
PGMethod(safeArray, "fd://Collection/NSArray/safe?safe=1&c=安全使用");
PGMethod(uiDemo, "fd://Collection/NSArray/UI?c=页面展示");

@end
