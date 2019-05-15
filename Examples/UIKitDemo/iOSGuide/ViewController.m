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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case 1001:
            [self.navigationController pushViewController:[UKUITextFieldViewController new] animated:YES];
            break;
        case 1003: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard1" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:[storyboard instantiateInitialViewController] animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
