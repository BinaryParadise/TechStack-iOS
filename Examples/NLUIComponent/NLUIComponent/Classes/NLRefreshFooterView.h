//
//  NLRefreshFooterView.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import "NLUIDefine.h"

/**
 底部刷新
 */
@interface NLRefreshFooterView : UIView

@property (nonatomic, assign) FDRefreshFooterViewState state;
@property (nonatomic, weak, readonly) UIScrollView *scrollView;

+ (instancetype)initWithTarget:(id)target selector:(SEL)selector;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
