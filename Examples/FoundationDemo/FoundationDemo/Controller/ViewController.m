//
//  ViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "ViewController.h"
#import "MCDataTypeDefine.h"
#import "MCBasicKnowledgeDefine.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<NSDictionary<NSString *, NSArray *> *> *marr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    self.marr = [NSMutableArray array];
    
    [self.marr addObject:@{@"基础数据类型":@[@[@"浮点数", JSFloatNumberViewController.class],
                                       @[@"NSArray", JSNSArrayViewController.class]
                                       ]}];
    
    [self.marr addObject:@{@"基础知识点":@[@[@"ARC", ARCViewController.class],
                                      @[@"锁", MCLockTableViewController.class],
                                       @[@"多线程", GCDViewController.class],
                                       @[@"算法", MCArithmeticTableViewController.class]
                                      ]}];
    [self.marr addObject:@{@"网络":@[@[@"日志", ARCViewController.class]]}];
    
    //[self validationLogger];
}

- (void)validationLogger {
    LogInfo(@"信息")
    LogDebug(@"调试")
    LogWarn(@"警告")
    LogError(@"错误")
    LogVerbose(@"啰嗦")
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.marr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.marr objectAtIndex:section].allValues.firstObject.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MCDemoHeaderFooterView *hederView = [[MCDemoHeaderFooterView alloc] initWithFrame:CGRectZero];
    [hederView setTitle:[self.marr objectAtIndex:section].allKeys.firstObject];
    return hederView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray *arr = [[self.marr objectAtIndex:indexPath.section].allValues.firstObject objectAtIndex:indexPath.row];
    MCDemoTableViewCell *cell = [MCDemoTableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.textLabel.text = arr.firstObject;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://127.0.0.1:8081/japi/logs" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LogDebug(@"success")
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LogDebug(@"%@ %@", [NSURLSessionConfiguration defaultSessionConfiguration], task.taskDescription);
        }];
        return;
    }
    NSArray *arr = [[self.marr objectAtIndex:indexPath.section].allValues.firstObject objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[arr.lastObject new] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
