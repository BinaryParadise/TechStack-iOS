//
//  NLAutoRefreshTableView.h
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import "NLRefreshFooterView.h"

@interface NLAutoRefreshTableView : UITableView

@end

@interface UITableView (FDRefresh)

@property (nonatomic, strong) NLRefreshFooterView *fd_footer;

@end
