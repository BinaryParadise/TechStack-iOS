//
//  ARCViewController.m
//  iOSGuide
//
//  Created by odyang on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
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
    arcObject = [ARCDemo new];
    NSLog(@"🍺%s +%d", __FUNCTION__, __LINE__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"🍺%s +%d", __FUNCTION__, __LINE__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"🍺%s +%d", __FUNCTION__, __LINE__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"🍺%s +%d", __FUNCTION__, __LINE__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"🍺%s +%d", __FUNCTION__, __LINE__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%s +%d", __FUNCTION__, __LINE__);
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        [arcObject testAssign];
    }
}

@end
