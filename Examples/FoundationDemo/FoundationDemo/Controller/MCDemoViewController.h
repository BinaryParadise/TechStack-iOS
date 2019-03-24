//
//  MCTableViewController.h
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../View/MCDemoTableViewCell.h"
#import "../View/MCDemoHeaderFooterView.h"
#import <MCUIKit/UIColor+MCExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCDemoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
