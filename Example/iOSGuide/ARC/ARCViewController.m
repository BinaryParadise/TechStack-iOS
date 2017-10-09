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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
