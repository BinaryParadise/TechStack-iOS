//
//  FDAutoRefreshTableView.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import "FDRefreshFooterView.h"

@interface FDAutoRefreshTableView : UITableView

@end

@interface UITableView (FDRefresh)

@property (nonatomic, strong) FDRefreshFooterView *fd_footer;

@end
