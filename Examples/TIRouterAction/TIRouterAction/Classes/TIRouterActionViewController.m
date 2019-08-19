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

@interface TIRouterActionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, NSArray<PGRouterConfig *> *> *> *data;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TIRouterActionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:[self.class routerActionBundle]]) {
        self.title = @"";
    }
    return self;
}

+ (NSBundle *)routerActionBundle {
    return [NSBundle bundleWithURL:[[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"TIRouterAction.bundle"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = MCHexColor(0xF6F6F6);
    NSMutableArray<NSDictionary<NSString *, NSArray<PGRouterConfig *> *> *> *marr = [NSMutableArray array];
    [[PGRouterManager routerMap] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<PGRouterConfig *> * _Nonnull obj, BOOL * _Nonnull stop) {
        NSArray *sorted = [obj sortedArrayUsingComparator:^NSComparisonResult(PGRouterConfig * _Nonnull obj1, PGRouterConfig *  _Nonnull obj2) {
            return [obj1.actionName compare:obj2.actionName];
        }];
        [marr addObject:@{key:sorted}];
    }];
    self.data = [marr sortedArrayUsingComparator:^NSComparisonResult(NSDictionary<NSString *, NSArray<PGRouterConfig *> *> * _Nonnull obj1, NSDictionary<NSString *, NSArray<PGRouterConfig *> *> *  _Nonnull obj2) {
        return [obj1.allKeys.firstObject compare:obj2.allKeys.firstObject];
    }];
    
    self.tableView.separatorColor = MCHexColor(0xECECEC);
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerClass:[TIRouterActionCell class] forCellReuseIdentifier:@"TIRouterActionCell"];
    self.tableView.backgroundColor = self.view.backgroundColor;
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
    return [self.data[section].allValues.firstObject count];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    NSArray<PGRouterConfig *> *items = self.data[section].allValues.firstObject;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 0, 0)];
    header.font = [UIFont fontWithName:@"DINAlternate-Bold" size:13];
    header.textColor = MCHexColor(0x333333);
    header.text = [NSString stringWithFormat:@"%@(%ld)", items.firstObject.URL.host, items.count];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(16);
        make.centerY.equalTo(headerView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = MCHexColor(0xECECEC);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(headerView);
        make.height.mas_equalTo(@0.5);
    }];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TIRouterActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TIRouterActionCell" forIndexPath:indexPath];
    PGRouterConfig *item = self.data[indexPath.section].allValues.firstObject[indexPath.row];
    cell.nameLabel.text = [item actionName];
    cell.descLabel.text = [item.parameters[@"c"] stringByRemovingPercentEncoding];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray<PGRouterConfig *> *items = self.data[indexPath.section].allValues.firstObject;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].graceTime = 10;
    [PGRouterManager openURL:items[indexPath.row].URL.absoluteString  completion:^(BOOL ret, id object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

@end
