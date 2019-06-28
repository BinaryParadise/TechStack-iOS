//
//  UITableViewCell+MCRegister.m
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "UITableViewCell+MCRegister.h"

@implementation UITableViewCell (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView {
    [tableView registerClass:self.class forCellReuseIdentifier:NSStringFromClass(self.class)];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath) {     
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    } else {
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    }
}

@end
