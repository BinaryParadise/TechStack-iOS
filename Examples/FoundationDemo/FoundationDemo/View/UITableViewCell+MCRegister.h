//
//  UITableViewCell+MCRegister.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/3/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath * _Nullable )indexPath;

@end

NS_ASSUME_NONNULL_END
