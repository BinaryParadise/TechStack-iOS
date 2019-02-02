//
//  ARCViewController.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 joenggaa. All rights reserved.
//

#import "ARCViewController.h"
#import "ARCDemo.h"

@interface ARCViewController () {
    ARCDemo *arcObject;//默认为strong
}

@end

@implementation ARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arcObject = [[ARCDemo alloc] initWithNumber:999];
    [arcObject testAssign];
    [arcObject testWeak];
    LogInfo(@"");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LogInfo(@"");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LogInfo(@"");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LogInfo(@"");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    LogInfo(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    LogInfo(@"");
}

@end
