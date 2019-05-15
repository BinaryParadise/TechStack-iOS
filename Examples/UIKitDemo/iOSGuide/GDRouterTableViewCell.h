//
//  GDRouterTableViewCell.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/15.
//  Copyright © 2019 joengzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGRouterConfig;

NS_ASSUME_NONNULL_BEGIN

@interface GDRouterTableViewCell : UITableViewCell

@property (nonatomic, strong) IBInspectable PGRouterConfig *config;
@property (nonatomic, copy) IBInspectable NSString *title;


@end

NS_ASSUME_NONNULL_END
