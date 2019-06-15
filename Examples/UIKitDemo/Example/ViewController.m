//
//  ViewController.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UKUITextFieldViewController.h"
#import <Peregrine/Peregrine.h>

@interface ViewController ()

@property (nonatomic, copy) NSArray<NSArray *> *data;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    LogWarn(@"据说地址不一样：%p", kTestKey);
    NSMutableArray *marr = [NSMutableArray array];
    [[PGRouterManager routerMap] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<PGRouterConfig *> * _Nonnull obj, BOOL * _Nonnull stop) {
        [marr addObject:@[key,obj]];
    }];
    self.data = marr;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"xxxxxx"];
}

- (void)xxx:(NSArray *)ddd {
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)self.data[section].lastObject count];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray<PGRouterConfig *> *items = self.data[section].lastObject;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 0, 0)];
    header.font = [UIFont systemFontOfSize:15];
    header.textColor = [UIColor darkTextColor];
    header.text = [NSString stringWithFormat:@"  %@", items.firstObject.URL.host];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxxxxx" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray<PGRouterConfig *> *items = self.data[indexPath.section].lastObject;
    cell.textLabel.text = [items[indexPath.row] actionName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray<PGRouterConfig *> *items = self.data[indexPath.section].lastObject;
    [PGRouterManager openURL:items[indexPath.row].URL.absoluteString  completion:^(BOOL ret, id object) {
        
    }];
}

@end
