//
//  UITableViewCell+MCRegister.h
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
