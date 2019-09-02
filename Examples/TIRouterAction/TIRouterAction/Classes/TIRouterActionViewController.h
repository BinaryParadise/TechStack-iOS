//
//  TIRouterActionViewController.h
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGRouterConfig;

NS_ASSUME_NONNULL_BEGIN

@interface TIRouterActionViewController : UIViewController

@property (nonatomic, copy) NSArray<PGRouterConfig *> *routers;

+ (NSBundle *)routerActionBundle;

@end

NS_ASSUME_NONNULL_END
