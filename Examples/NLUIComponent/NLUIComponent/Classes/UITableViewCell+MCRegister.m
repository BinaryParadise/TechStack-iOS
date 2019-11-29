//
//  UITableViewCell+MCRegister.m
//  Neverland
//
//  Created by Rake Yang on 2019/3/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "UITableViewCell+MCRegister.h"

@implementation UITableViewCell (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView {
    [self registerForTableView:tableView inBundle:nil];
}
+ (void)registerForTableView:(UITableView *)tableView inBundle:(nullable NSBundle *)bundle {
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    if (cellNib) {
        [tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([self class])];
    } else {
        [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
    }
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath * _Nullable)indexPath {
    if (indexPath) {     
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    } else {
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    }
}

+ (CGFloat)defaultHeightForData:(id)data {
    return 44.0;
}

@end
