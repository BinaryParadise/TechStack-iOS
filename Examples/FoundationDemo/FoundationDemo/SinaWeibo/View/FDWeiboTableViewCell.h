//
//  FDWeiboTableViewCell.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+MCRegister.h"
#import "../Model/FWBStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDWeiboTableViewCell : UITableViewCell

@property (nonatomic, strong) FWBStatus *status;

@end

NS_ASSUME_NONNULL_END
