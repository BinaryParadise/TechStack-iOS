//
//  PGUIViewController.m
//  iOSGuide
//
//  Created by lingjing on 2019/1/6.
//  Copyright © 2019年 mylcode. All rights reserved.
//

#import "PGUIViewController.h"
#import "PGDemoView.h"

@interface PGUIViewController ()

@end

@implementation PGUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = self.view.frame.size;
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
    PGDemoView *demoView = [[PGDemoView alloc] initWithFrame:CGRectMake(16, scrollView.frame.size.height - 99, 186, 66)];
    [scrollView addSubview:demoView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [demoView addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
