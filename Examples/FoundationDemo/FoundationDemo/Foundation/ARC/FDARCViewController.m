//
//  FDARCViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDARCViewController.h"
#import "JSARCDemoA.h"
#import "JSARCDemoB.h"

@interface FDARCViewController ()

@property (nonatomic, strong) JSARCDemoA *demoA;
@property (nonatomic, strong) JSARCDemoB *demoB;

@end

@implementation FDARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JSARCDemoA *demoA = [[JSARCDemoA alloc] initWithTag:@"强引用对象"];
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
