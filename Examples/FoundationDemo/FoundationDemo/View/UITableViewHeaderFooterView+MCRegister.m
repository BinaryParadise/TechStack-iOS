//
//  UITableViewHeaderFooterView+MCRegister.m
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "UITableViewHeaderFooterView+MCRegister.h"

@implementation UITableViewHeaderFooterView (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView {
    [tableView registerClass:self.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(self.class)];
}

+ (instancetype)viewForTableView:(UITableView *)tableView {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self.class)];
}

@end
