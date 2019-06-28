//
//  UITableViewHeaderFooterView+MCRegister.h
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView;

+ (instancetype)viewForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
