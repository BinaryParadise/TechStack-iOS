//
//  NLMCArithmeticTableViewController.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/25.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLMCArithmeticTableViewController.h"

@interface NLMCArithmeticTableViewController ()

@end

@implementation NLMCArithmeticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

void arithmetic1(const char *str) {
    for (int i=(int)strlen(str)-1; i>=0; i--) {
        printf("%c", str[i]);
    }
}


/**
 数组中的第K个最大元素
 */
void bigNumFK(int k) {
    //冒泡排序
    int numbers[] = {1, 6, 3, 5, 7, 4, 8, 11, 12};
    int size = sizeof(numbers)/sizeof(numbers[0]);
    int count = 0;
    for (int i=0; i<size-1; i++) {
        for (int j=0; j<size-1-i; j++) {
            count++;
            if (numbers[j] > numbers[j+1]) {
                int num = numbers[j+1];
                numbers[j+1] = numbers[j];
                numbers[j] = num;
            }
        }
    }
    printf("第K=%d大的数是%d, 计算次数=%d", k, numbers[size-k], count);
}

void quickSort(int k) {
    //快速排序
    int numbers[] = {1, 6, 3, 5, 7, 4, 8, 11, 12};
    int right[] = {};
    int left[] = {};
    int size = sizeof(numbers)/sizeof(numbers[0]);
    int num = numbers[k];
    for (int i=0; i<size; i++) {
        if (numbers[i] > num) {
            right[sizeof(right)/sizeof(int)+1] = numbers[i];
        } else {
            left[sizeof(left)/sizeof(int)+1] = numbers[i];
        }
    }
    printf("");
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            arithmetic1("Can you reverse this string?");
            break;
        case 1: {
            bigNumFK(3);
            quickSort(3);
        }
            break;
        default:
            break;
    }
}

@end
