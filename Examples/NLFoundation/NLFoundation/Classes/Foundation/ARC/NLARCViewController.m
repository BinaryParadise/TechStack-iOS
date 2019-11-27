//
//  NLARCViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLARCViewController.h"
#import "NLJSARCDemoA.h"
#import "NLJSARCDemoB.h"

@interface NLARCViewController ()

@property (nonatomic, strong) NLJSARCDemoA *demoA;
@property (nonatomic, strong) NLJSARCDemoB *demoB;

@end

@implementation NLARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NLJSARCDemoA *demoA = [[NLJSARCDemoA alloc] initWithTag:@"强引用对象"];
    [demoA testAssign];
    [demoA testWeak];
    __weak typeof(self) self_weak = self;
    [demoA doSomething:^{
        //强引用，造成循环
        //[self brokeRecycle:nil];
        //weak打破循环
        [self_weak brokeRecycle:nil];
    }];
    self.demoA = demoA;
    self.demoA.strongDemo = self;
}

- (IBAction)brokeRecycle:(id)sender {
    self.demoA.strongDemo = nil;
    MCLogDebug(@"打破循环引用");
}

- (void)dealloc {
    MCLogWarn(@"");
}

@end
