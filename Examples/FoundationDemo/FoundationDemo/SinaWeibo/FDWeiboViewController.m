//
//  FDWeiboViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDWeiboViewController.h"
#import "FDAutoRefreshTableView.h"
#import "FDWeiboTableViewCell.h"
#import "FDWeiboPresenter.h"

@interface FDWeiboViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FDWeiboPresenter *presenter;

@end

@implementation FDWeiboViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.presenter = [[FDWeiboPresenter alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[FDAutoRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [FDWeiboTableViewCell registerForTableView:self.tableView];
    [self.presenter authorizeIfInvalid];
    [self.presenter fetchHomeTimeline:^(BOOL success, id  _Nullable data, NSError * _Nullable error) {
        [self.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDWeiboTableViewCell *cell = [FDWeiboTableViewCell cellForTableView:tableView indexPath:nil];
    return cell;
}

@end
