//
//  NLWeiboPresenter.h
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NLRouterAction/NLRouterAction.h>
#import "NLFWBRequestManager.h"
#import "NLWBStatusViewModel.h"
#import <MCObserverKit/MCObserverKit.h>

@interface NLWeiboPresenter : NSObject

@property (nonatomic, copy) NSArray<NLWBStatusViewModel *> *statuses;
@property (nonatomic, assign) BOOL authChanged;

/**
 如果当前认证无效时请求验证
 @return 是否失效
 */
+ (BOOL)authorizeIfInvalid;

/**
 前登录用户及其所关注（授权）用户的最新微博
 */
- (void)fetchHomeTimeline:(FDActionCompletion)completion;

+ (NSDictionary *)authData;
- (void)clearAuthData;

@end
