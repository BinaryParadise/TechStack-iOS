//
//  NLWeiboPresenter.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLWeiboPresenter.h"
#import <Weibo_SDK/WeiboSDK.h>
#import <MCLogger/MCLogger.h>
#import <NLRouterAction/NLRouterAction.h>
#import "NLWeiboResponse.h"

@interface NLWeiboPresenter () <WeiboSDKDelegate>

@property (nonatomic, strong) NLWeiboResponse *header;


@end

@implementation NLWeiboPresenter

- (void)authorizeIfInvalid {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"]) {
        [self fetchEmotions];
        return;
    }
    WBAuthorizeRequest *request =[[WBAuthorizeRequest alloc] init];
    request.redirectURI = @"http://www.sina.com";
    [WeiboSDK sendRequest:request];
}

- (void)fetchHomeTimeline:(FDActionCompletion)completion {
    NSDictionary *params;
    if (self.header) {
        params = @{@"max_id": @(self.statuses.lastObject.mid)};
    }
    [NLFWBRequestManager getDataWithURL:@"statuses/home_timeline.json" params:params completion:^(id  _Nonnull data, NSError * _Nonnull error) {
        self.header = [NLWeiboResponse fd_objectFromKeyValues:data];
        NSArray *statuses = [NLFWBStatus fd_arrayOfModelsFromKeyValues:data[@"statuses"]];
        if (self.statuses) {
            self.statuses = [self.statuses arrayByAddingObjectsFromArray:statuses];
        } else {
            self.statuses = statuses;
        }
        if (completion) {
            completion(statuses, error);
        }
    }];
}

- (void)fetchEmotions {
    [NLFWBRequestManager getDataWithURL:@"emotions.json" params:nil completion:^(id  _Nullable data, NSError * _Nullable error) {
        if (error) {
            NLLogError(@"%@", error);
        }
    }];
}

@end
