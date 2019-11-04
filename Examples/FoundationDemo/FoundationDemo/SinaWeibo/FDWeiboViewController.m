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
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.fd_footer = [FDRefreshFooterView initWithTarget:self selector:@selector(refreshData)];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    [FDWeiboTableViewCell registerForTableView:self.tableView];
    
    [MCObserver(self.presenter, statuses) valueChanged:^(id target, id value) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    }];
    
    [self.presenter authorizeIfInvalid];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refreshData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Actions

- (void)refreshData {
    [self.presenter fetchHomeTimeline:^(BOOL success, id  _Nullable data, NSError * _Nullable error) {
        [self.tableView.fd_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDWeiboTableViewCell *cell = [FDWeiboTableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.status = self.presenter.statuses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

@end
