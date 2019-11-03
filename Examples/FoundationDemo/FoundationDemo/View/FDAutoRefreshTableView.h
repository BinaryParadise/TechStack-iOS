//
//  FDAutoRefreshTableView.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDAutoRefreshTableView : UITableView

@end

typedef NS_OPTIONS(NSUInteger, FDRefreshFooterViewState) {
    FDRefreshFooterViewStateIdle = 0,
    FDRefreshFooterViewStateRefreshing = 1 << 0
};

@interface FDRefreshFooterView : UIView

@property (nonatomic, assign) FDRefreshFooterViewState state;
@property (nonatomic, weak, readonly) UIScrollView *scrollView;

@end

@interface UITableView (FDRefresh)

@property (nonatomic, strong) FDRefreshFooterView *fd_footer;
@property (nonatomic, assign, readonly) BOOL refreshing;


- (void)beginRefreshing;

- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
