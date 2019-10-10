//
//  GDTabBarController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDTabBarController.h"
#import <TIRouterAction/TIRouterAction.h>

@implementation GDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    DDLogDebug(@"");
    [self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DDLogDebug(@"");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DDLogDebug(@"");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    DDLogDebug(@"");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    DDLogDebug(@"");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSNumber *hidden = change[NSKeyValueChangeNewKey];
    DDLogInfo(@"%@", hidden);
}

- (void)dealloc {
    [self.tabBar removeObserver:self forKeyPath:@"hidden"];
}

@end
