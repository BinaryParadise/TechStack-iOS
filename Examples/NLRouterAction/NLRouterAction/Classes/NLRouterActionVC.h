//
//  NLRouterActionVC.h
//  NLRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGRouterNode;

NS_ASSUME_NONNULL_BEGIN

@interface NLRouterActionVC : UIViewController

@property (nonatomic, weak) PGRouterNode *routerNode;

@end

NS_ASSUME_NONNULL_END
