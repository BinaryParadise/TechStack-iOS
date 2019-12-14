//
//  ViewController.m
//  WBReactNative
//
//  Created by Rake Yang on 2019/12/12.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>
#import <NLModuleService/NLModuleService.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NLM_Weibo authorizeIfInvalid];
    });
}

- (IBAction)showNative:(id)sender {
    [self.navigationController pushViewController:NLM_Weibo.nativeController animated:YES];
}

- (IBAction)showRoot:(id)sender {
    
    NSURL *jsCodeLocation = [self bundleURL];
    self.navigationController.navigationBarHidden = YES;
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"weibo_sso_data"];
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                moduleName: @"WBReactNative"
                         initialProperties: dict
                             launchOptions: nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    nav.topViewController.view = rootView;
    nav.navigationBarHidden = YES;
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (NSURL *)bundleURL {
#if DEBUG
    return [NSURL URLWithString:@"http://127.0.0.1:8081/index.bundle?platform=ios"];
#else
    return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
