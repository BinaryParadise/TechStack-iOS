//
//  ViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "ViewController.h"
#import "MCBasicKnowledgeDefine.h"
#import <AFNetworking/AFNetworking.h>
#import "MCDemoHeaderFooterView.h"
#import "MCDemoTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    if (!self.marr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Menus.json" ofType:nil];
        NSDictionary *configMenus = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:nil];
        self.marr = [MCDynamicAction mj_objectArrayWithKeyValuesArray:configMenus[@"groups"]];
    }
    
    [MCDemoTableViewCell registerForTableView:self.tableView];
    //[self.tableView reloadData];
    /*[self.marr addObject:@{@"基础知识点":@[@[@"ARC", ARCViewController.class],
                                      @[@"锁", MCLockTableViewController.class],
                                       @[@"多线程", GCDViewController.class],
                                       @[@"算法", MCArithmeticTableViewController.class]
                                      ]}];
    [self.marr addObject:@{@"网络":@[@[@"日志", ARCViewController.class]]}];*/
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.action ? 1 : self.marr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self numberOfSectionsInTableView:tableView] > 1) {
        return self.marr[section].items.count;
    } else {
        return self.marr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MCDemoHeaderFooterView *hederView = [[MCDemoHeaderFooterView alloc] initWithFrame:CGRectZero];
    if (!self.action) {
        [hederView setTitle:self.marr[section].title];
        return hederView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MCDynamicAction *actionItem = self.action ? self.marr[indexPath.row] : self.marr[indexPath.section].items[indexPath.row];
    MCDemoTableViewCell *cell = [MCDemoTableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.textLabel.text = actionItem.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 2) {
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:@"https://www.apple.com/cn/iPhoneX1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            LogDebug(@"success")
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            LogDebug(@"%@ %@", [NSURLSessionConfiguration defaultSessionConfiguration], task.taskDescription);
//        }];
//        return;
//    }
    if (!self.action) {
        MCDynamicAction *actionItem = self.marr[indexPath.section].items[indexPath.row];
        ViewController *vc = [[ViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
        vc.title = actionItem.title;
        vc.marr = actionItem.items;
        Class actionCls = NSClassFromString(actionItem.action);
        vc.action = [[actionCls alloc] init];
        NSAssert(vc.action, @"创建实例失败%@", actionItem.action);
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.action performSelector:NSSelectorFromString(self.marr[indexPath.row].action)];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.animationType = MBProgressHUDAnimationFade;
        hud.label.text = @"done";
        [hud hideAnimated:YES afterDelay:1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
