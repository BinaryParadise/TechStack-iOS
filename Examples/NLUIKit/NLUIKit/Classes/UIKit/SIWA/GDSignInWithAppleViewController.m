//
//  GDSignInWithAppleViewController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/10/9.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDSignInWithAppleViewController.h"
#import <Masonry/Masonry.h>
#import <AuthenticationServices/AuthenticationServices.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
@interface GDSignInWithAppleViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@end
#endif

@implementation GDSignInWithAppleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    ASAuthorizationAppleIDButton *authorButton = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleBlack];
        [authorButton addTarget:self action:@selector(authorAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:authorButton];
        [authorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(28);
        }];
#endif
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self perfomExistingAccountSetupFlows];
}

/// 处理授权
/// @param sender sender
- (void)authorAction:(id)sender {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        // Creates a new Apple ID authorization request.
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        // The contact information to be requested from the user during authentication.
        // 在用户授权期间请求的联系信息
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // A controller that manages authorization requests created by a provider.
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        // 设置授权控制器通知授权请求的成功与失败的代理
        controller.delegate = self;
        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        controller.presentationContextProvider = self;
        // starts the authorization flows named during controller initialization.
        // 在控制器初始化期间启动授权流
        [controller performRequests];
}

/// 校验
- (void)checkCredential:(ASAuthorizationAppleIDCredential *)appleID  API_AVAILABLE(ios(13.0)){
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://appleid.apple.com/auth/token"]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSMutableString *postStr = [NSMutableString string];
    [postStr appendFormat:@"client_id=%@", [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]];
}

/// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccountSetupFlows {
    if (@available(iOS 13.0, *)) {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        // An OpenID authorization request that relies on the user’s Apple ID.
        // 授权请求依赖于用于的AppleID
        ASAuthorizationAppleIDRequest *authAppleIDRequest = [appleIDProvider createRequest];
        // A mechanism for generating requests to perform keychain credential sharing.
        // 为了执行钥匙串凭证分享生成请求的一种机制
        ASAuthorizationPasswordRequest *passwordRequest = [[ASAuthorizationPasswordProvider new] createRequest];
        
        NSMutableArray <ASAuthorizationRequest *>* mArr = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [mArr addObject:authAppleIDRequest];
        }
        if (passwordRequest) {
            [mArr addObject:passwordRequest];
        }
        // ASAuthorizationRequest：A base class for different kinds of authorization requests.
        // ASAuthorizationRequest：对于不同种类授权请求的基类
        NSArray <ASAuthorizationRequest *>* requests = [mArr copy];
        
        // A controller that manages authorization requests created by a provider.
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        // Creates a controller from a collection of authorization requests.
        // 从一系列授权请求中创建授权控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // starts the authorization flows named during controller initialization.
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return self.view.window;
}

#pragma mark - ASAuthorizationControllerDelegate

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        [[NSUserDefaults standardUserDefaults] setObject:credential.user forKey:@"appleid_user"];
        NLLogDebug(@"user: %@", credential.user);
        NLLogDebug(@"fullName: %@%@%@", credential.fullName.familyName?:@"", credential.fullName.middleName?:@"", credential.fullName.givenName?:@"");
        NLLogDebug(@"email: %@", credential.email);
        NLLogDebug(@"authorizationCode: %@", [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]);
        NLLogDebug(@"Identify: %@", [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]);
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    if (error) {
        NLLogError(@"%@", error);
        NSString *errorMsg = @"授权请求失败未知原因";
        switch (error.code) {
            case ASAuthorizationErrorCanceled:
                errorMsg = @"用户取消了授权请求";
                break;
            case ASAuthorizationErrorFailed:
                errorMsg = @"授权请求失败";
                break;
            case ASAuthorizationErrorInvalidResponse:
                errorMsg = @"授权请求响应无效";
                break;
            case ASAuthorizationErrorNotHandled:
                errorMsg = @"未能处理授权请求";
                break;
            default:
                break;
        }
        NLLogError(@"%@", error);
    }
}

#endif

@end
