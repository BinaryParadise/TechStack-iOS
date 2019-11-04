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
#import <Toast/Toast.h>
#import "FDPlaceholderView.h"

@interface FDWeiboViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FDWeiboPresenter *presenter;
@property (nonatomic, strong) FDPlaceholderView *emptyView;


@end

@implementation FDWeiboViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.presenter = [[FDWeiboPresenter alloc] init];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MCHexColor(0xF6F6F6);
    
    self.emptyView = [[FDPlaceholderView alloc] init];
    self.emptyView.hidden = YES;
    self.emptyView.onButtonClick = ^{
        [self refreshData:FDRefreshStateFirst];
    };
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView = [[FDAutoRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.fd_footer = [FDRefreshFooterView initWithTarget:self selector:@selector(refreshData:)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [FDWeiboTableViewCell registerForTableView:self.tableView];
    
    [MCObserver(self.presenter, authChanged) valueChanged:^(id target, id value) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshData:FDRefreshStateFirst];
        });
    }];
    
    [self.presenter authorizeIfInvalid];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refreshData:FDRefreshStateFirst];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Actions

- (void)refreshData:(FDRefreshState)state {
    if (state == FDRefreshStateFirst) {
        self.presenter.statuses = nil;
    }
    [self.presenter fetchHomeTimeline:^(id  _Nullable data, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.emptyView.hidden = !error;
            self.tableView.hidden = error;
            [self.tableView.fd_footer endRefreshing];
            if (error) {
                [self.view makeToast:error.localizedDescription];
            } else {
                [self reloadData];
            }
        });
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.presenter.statuses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDWeiboTableViewCell *cell = [FDWeiboTableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.status = self.presenter.statuses[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FDWeiboTableViewCell defaultHeightForData:self.presenter.statuses[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    DDLogDebug(@"%@ %@ %@", NSStringFromUIEdgeInsets(scrollView.contentInset), NSStringFromCGPoint(scrollView.contentOffset), NSStringFromCGSize(scrollView.contentSize));
}

@end
