//
//  NLWeiboPresenter.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLWeiboPresenter.h"
#import <Weibo_SDK/WeiboSDK.h>
#import <NLRouterAction/NLRouterAction.h>
#import "NLWeiboResponse.h"

@interface NLWeiboPresenter ()

@property (nonatomic, strong) NLWeiboResponse *header;

@end

@implementation NLWeiboPresenter

+ (BOOL)authorizeIfInvalid {
    if ([self authData]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self fetchEmotions];
        });
        return NO;
    }
    WBAuthorizeRequest *request =[[WBAuthorizeRequest alloc] init];
    request.redirectURI = @"http://www.sina.com";
    [WeiboSDK sendRequest:request];
    return YES;
}

- (void)fetchHomeTimeline:(FDActionCompletion)completion {
    NSDictionary *params;
    if ([self.class authorizeIfInvalid]) {
        return;
    }
    if (self.header) {
        params = @{@"max_id": @(self.statuses.lastObject.maxId)};
    }
    [NLFWBRequestManager getDataWithURL:@"statuses/home_timeline.json" params:params completion:^(id  _Nonnull data, NSError * _Nonnull error) {
        self.header = [NLWeiboResponse fd_objectFromKeyValues:data];
        NSArray *statuses = [NLFWBStatus fd_arrayOfModelsFromKeyValues:data[@"statuses"]];
        if (self.statuses) {
            self.statuses = [self.statuses arrayByAddingObjectsFromArray:[NLWBStatusViewModel arrayWithStatuses:statuses]];
        } else {
            self.statuses = [NLWBStatusViewModel arrayWithStatuses:statuses];
        }
        if (completion) {
            completion(statuses, error);
        }
    }];
}

- (void)shareTest:(FDActionCompletion)completion {
    WBMessageObject *msg = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject new];
    webpage.objectID = NSUUID.UUID.UUIDString;
    webpage.title = @"来看我直播CSGO吧";
    webpage.description = @"不知道了";
    webpage.webpageUrl = @"https://www.bilibili.com";
    msg.mediaObject = webpage;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg];
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

+ (void)fetchEmotions {
    [NLFWBRequestManager getDataWithURL:@"emotions.json" params:nil completion:^(id  _Nullable data, NSError * _Nullable error) {
        if (error) {
            NLLogError(@"%@", error);
        }
    }];
}

+ (NSDictionary *)authData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"];
}

- (void)clearAuthData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"weibo_sso_data"];
    self.authChanged = NO;
}

@end
