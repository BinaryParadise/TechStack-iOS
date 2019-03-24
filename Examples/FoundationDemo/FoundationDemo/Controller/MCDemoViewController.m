//
//  MCTableViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCDemoViewController.h"

@interface MCDemoViewController ()

@end

@implementation MCDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = MCHexColor(0xEBEBEB);
    self.title = @"Demo";
    [MCDemoTableViewCell registerForTableView:self.tableView];
    self.tableView.tableFooterView = [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

@end
