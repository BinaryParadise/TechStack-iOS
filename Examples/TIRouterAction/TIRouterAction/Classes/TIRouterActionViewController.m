//
//  TIRouterActionViewController.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TIRouterActionViewController.h"
#import <Peregrine/Peregrine.h>
#import "TIRouterActionCell.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "TIRouterAction.h"
#import "TIRouterUIHelper.h"

@interface TIRouterActionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray<PGRouterNode *> *data;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TIRouterActionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:[self.class routerActionBundle]]) {
        self.title = @"路由表";
    }
    return self;
}

+ (NSBundle *)routerActionBundle {
    return [NSBundle bundleWithURL:[[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"TIRouterAction.bundle"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (self.routerNode) {
        self.title = self.routerNode.name;
        self.data = @[self.routerNode];
    } else {
        self.data = [[PGRouterManager routerMap].allValues sortedArrayUsingComparator:^NSComparisonResult(PGRouterNode *  _Nonnull obj1, PGRouterNode * _Nonnull obj2) {
            return [obj1.name compare:obj2.name];
        }];
        [self.data enumerateObjectsUsingBlock:^(PGRouterNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.childs sortUsingComparator:^NSComparisonResult(PGRouterNode *  _Nonnull obj11,  PGRouterNode * _Nonnull obj22) {
                return [obj11.name compare:obj22.name];
            }];
        }];
    }
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
//    if (@available(iOS 11.0, *)) {
//        self.tableView.insetsContentViewsToSafeArea = NO;
//    }
    [self.tableView registerClass:[TIRouterActionCell class] forCellReuseIdentifier:@"TIRouterActionCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data[section].childs.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section < self.data.count - 1 ? 10 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor ti_section];
    
    PGRouterNode *node = self.data[section];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 0, 0)];
    header.textColor = [UIColor ti_white];
    header.font = [UIFont fontWithName:@"DINAlternate-Bold" size:13];
    header.text = [NSString stringWithFormat:@"%@（%ld）", node.name, node.childs.count];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(16);
        make.centerY.equalTo(headerView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor ti_line1];
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(headerView);
        make.height.mas_equalTo(@0.5);
    }];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TIRouterActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TIRouterActionCell" forIndexPath:indexPath];
    PGRouterNode *item = self.data[indexPath.section].childs[indexPath.row];
    if (item.config) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.nameLabel.text = [item.config actionName];
        cell.descLabel.text = [item.config.parameters[@"c"] stringByRemovingPercentEncoding];
    } else {
        cell.nameLabel.text = item.name;
        cell.descLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PGRouterNode *node = self.data[indexPath.section].childs[indexPath.row];
    if (!node.config) {
        TIRouterActionViewController *nodeVC = [[TIRouterActionViewController alloc] init];
        nodeVC.routerNode = node;
        nodeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nodeVC animated:YES];
        return;
    }
    PGRouterConfig *config = node.config;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self actionBegin:config.actionName];
    __block BOOL finished;
    [PGRouterManager openURL:config.URL.absoluteString  completion:^(BOOL ret, id object) {
        finished = YES;
        if (!ret) {
            MCLogError(@"%@", object);
        }
        [self actionEnd:config.actionName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!finished) {
            finished = YES;
            [self actionTimeout:config.actionName];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    });
}

- (void)actionBegin:(NSString *)name {
    MCLogInfo(@"------------------------%@ BEGIN------------------------", name);
}

- (void)actionEnd:(NSString *)name {
    MCLogInfo(@"------------------------%@ END------------------------", name);
}

- (void)actionTimeout:(NSString *)name {
    MCLogInfo(@"------------------------%@ END TIMEOUT------------------------", name);
}

@end
