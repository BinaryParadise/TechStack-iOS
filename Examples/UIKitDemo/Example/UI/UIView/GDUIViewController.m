//
//  GDUIViewController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/10/22.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDUIViewController.h"
#import "GDDemoView.h"

@interface GDUIViewController ()

@end

@implementation GDUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GDDemoView *demoView = [[GDDemoView alloc] init];
    [demoView setNeedsLayout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
