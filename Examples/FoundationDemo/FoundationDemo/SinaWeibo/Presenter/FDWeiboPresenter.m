//
//  FDWeiboPresenter.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDWeiboPresenter.h"
#import <Weibo_SDK/WeiboSDK.h>
#import <MCLogger/MCLogger.h>
#import <TIRouterAction/TIRouterAction.h>
#import "FDWeiboResponse.h"

@interface FDWeiboPresenter () <WeiboSDKDelegate>

@property (nonatomic, strong) FDWeiboResponse *header;


@end

@implementation FDWeiboPresenter

+ (void)initWeibo:(PGRouterContext *)context {
    static dispatch_once_t onceToken;
    __block BOOL ret;
    dispatch_once(&onceToken, ^{
        [WeiboSDK enableDebugMode:YES];
        //bundle id不能大写
        ret = [WeiboSDK registerApp:context.userInfo[@"appKey"]];
    });
    [context onDone:ret object:nil];
}

+ (void)openWeiboURL:(PGRouterContext *)context {
    static FDWeiboPresenter *wbp;
    if (!wbp) {
        wbp = [FDWeiboPresenter new];
    }
    BOOL canOpen = [WeiboSDK handleOpenURL:context.object delegate:wbp];
    [context onDone:canOpen object:nil];
}

- (void)authorizeIfInvalid {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"]) {
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
    [FDWeiboRequest getDataWithURL:@"statuses/home_timeline.json" params:nil completion:^(BOOL success, id  _Nonnull data, NSError * _Nonnull error) {
        self.header = [FDWeiboResponse fd_objectFromKeyValues:data];
        self.statuses = [FWBStatus fd_arrayOfModelsFromKeyValues:data[@"statuses"]];
        if (completion) {
            completion(success, self.statuses, error);
        }
    }];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:response.userInfo forKey:@"weibo_sso_data"];
        }
    } else {
        DDLogError(@"%@", response.userInfo);
    }
}

@end
