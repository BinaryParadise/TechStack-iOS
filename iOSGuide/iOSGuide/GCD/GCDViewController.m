//
//  GCDViewController.m
//  iOSGuide
//
//  Created by odyang on 2017/10/8.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDDemo.h"


@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[GCDDemo asyncConcurrent];
    //[GCDDemo asyncSerial];
    //[GCDDemo syncConcurrent];
    //[GCDDemo syncSerial];
    //[GCDDemo syncMain];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LogWarn(@"%@", [NSThread mainThread]);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        switch (row) {
            case 0:
                [GCDDemo asyncConcurrent];
                break;
            case 1:
                [GCDDemo syncConcurrent];
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        switch (row) {
            case 0:
                [GCDDemo asyncSerial];
                break;
            case 1:
                [GCDDemo syncSerial];
            default:
                break;
        }
    }else if (section == 2) {
        [GCDDemo gloabConcurrent:row==0];
    }else if (section == 3) {
        switch (row) {
            case 0:
                [GCDDemo asyncMain];
                break;
            case 1:
                [GCDDemo syncMain];
            default:
                break;
        }
    }else if (section == 4) {
        switch (row) {
            case 0:
                [GCDDemo dispatchGroup:NO];
                break;
            case 1:
                [GCDDemo dispatchGroup:YES];
            default:
                break;
        }
    }else if (section == 5) {
        if (row == 0) {
            [GCDDemo dispatchBarrier:YES];
        }else {
            [GCDDemo dispatchBarrier:NO];
        }
    }else if (section == 6) {
        if (row == 0) {
            [GCDDemo dispatchSemaphore:YES];
        }else {
            [GCDDemo dispatchSemaphore:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
