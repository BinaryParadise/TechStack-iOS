//
//  NLWeiboViewController.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLMVPWeiboViewController.h"
#import <NLUIComponent/NLUIComponent.h>
#import "NLWeiboPresenter.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "NLWeiboTableViewCell.h"
#import <NLModuleService/NLModuleService.h>
#import "NLWBAccountViewController.h"

@interface NLMVPWeiboViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NLWeiboPresenter *presenter;
@property (nonatomic, strong) NLPlaceholderView *emptyView;

@end

@implementation NLMVPWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MCHexColor(0xF6F6F6);
        
    self.presenter = [[NLWeiboPresenter alloc] init];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    
    self.emptyView = [[NLPlaceholderView alloc] init];
    self.emptyView.hidden = YES;
    __weak typeof(self) self_weak = self;
    self.emptyView.onButtonClick = ^{
        [self_weak refreshData:FDRefreshStateFirst];
    };
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView = [[NLAutoRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.fd_footer = [NLRefreshFooterView initWithTarget:self selector:@selector(refreshData:)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [NLWeiboTableViewCell registerForTableView:self.tableView inBundle:NLM_Weibo.resourceBundle];
    
    [MCObserver(self.presenter, authChanged) valueChanged:^(id target, id value) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self_weak refreshData:FDRefreshStateFirst];
        });
    }];
    
    if (![NLWeiboPresenter authData]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否需要授权?" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonClick:)];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self refreshData:FDRefreshStateFirst];
        }]];
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Actions

- (void)rightButtonClick:(id)sender {
    NLWBAccountViewController *accountVC = [NLWBAccountViewController new];
    accountVC.presenter = self.presenter;
    accountVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:accountVC animated:YES];
}

- (void)shareButtonClick:(id)sender {
    [self.presenter shareTest:^(id  _Nullable data, NSError * _Nullable error) {
        
    }];
}

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
    if ([NLWeiboPresenter authData]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账号" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick:)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.presenter.statuses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NLWeiboTableViewCell *cell = [NLWeiboTableViewCell cellForTableView:tableView indexPath:indexPath];
    [cell fillWithViewModel:self.presenter.statuses[indexPath.section]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NLWeiboTableViewCell defaultHeightForData:self.presenter.statuses[indexPath.section]];
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
