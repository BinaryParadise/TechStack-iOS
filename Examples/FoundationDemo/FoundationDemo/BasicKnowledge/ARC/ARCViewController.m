//
//  ARCViewController.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "ARCViewController.h"
#import "JSARCDemoA.h"
#import "JSARCDemoB.h"

@interface ARCViewController () {
    JSARCDemoA *arcObject;//默认为strong
}

@end

@implementation ARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arcObject = [[JSARCDemoA alloc] initWithTag:@"主要对象"];
    JSARCDemoB *demoB = [[JSARCDemoB alloc] initWithTag:@"附属对象"];
    demoB.arcDemo = arcObject;
    arcObject.demoB = demoB;
    [arcObject testAssign];
    [arcObject testWeak];

    //block retain cycle
    [arcObject doSomething:^{
        [demoB doSomething];
    }];

    MCLogInfo(@"");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MCLogInfo(@"");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MCLogInfo(@"");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    MCLogInfo(@"");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    MCLogInfo(@"");
}

- (IBAction)releaseObj:(id)sender {
    arcObject = nil;
//    [MCLogger showConsoleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    MCLogInfo(@"");
}

@end
