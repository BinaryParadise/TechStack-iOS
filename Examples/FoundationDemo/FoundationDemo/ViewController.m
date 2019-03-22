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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"dftcell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.marr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.marr objectAtIndex:section].allValues.firstObject.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary<NSString *, NSArray *> *dict = [self.marr objectAtIndex:section];
    return dict.allKeys.firstObject;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray *arr = [[self.marr objectAtIndex:indexPath.section].allValues.firstObject objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dftcell" forIndexPath:indexPath];
    cell.textLabel.text = arr.firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [[self.marr objectAtIndex:indexPath.section].allValues.firstObject objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BasicKnowledge" bundle:nil];
    UIViewController *destVC;
    @try {
        destVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(arr.lastObject)];
    } @catch (NSException *exception) {
        destVC = [arr.lastObject new];
    } @finally {
        [self.navigationController pushViewController:[arr.lastObject new] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
