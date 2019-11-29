//
//  UITableViewCell+MCRegister.h
//  Neverland
//
//  Created by Rake Yang on 2019/3/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewHeaderFooterView+MCRegister.h"

@interface UITableViewCell (MCRegister)

+ (void)registerForTableView:(UITableView *)tableView;
+ (void)registerForTableView:(UITableView *)tableView inBundle:(NSBundle *)bundle;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath * _Nullable )indexPath;

+ (CGFloat)defaultHeightForData:(id)data;

@end
