//
//  FDRefreshFooterView.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDAutoRefreshTableView.h"
#import <objc/runtime.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import <Masonry/Masonry.h>

@interface FDRefreshFooterView ()

@property (nonatomic, strong) UIActivityIndicatorView *indictorView;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) BOOL oneNewPan;

@end

@implementation FDRefreshFooterView

+ (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    FDRefreshFooterView *view = [[FDRefreshFooterView alloc] initWithFrame:CGRectMake(0, 0, 0, 36)];
    view.target = target;
    view.selector = selector;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _indictorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indictorView];
        [_indictorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setState:(FDRefreshFooterViewState)state {
    void(^setStateBlock)(void) = ^() {
        switch (state) {
            case FDRefreshFooterViewStateIdle:
                if ([self.indictorView isAnimating]) {
                    [self.indictorView stopAnimating];
                }
                self.indictorView.hidden = YES;
                break;
            case FDRefreshFooterViewStateRefreshing:
                self.indictorView.hidden = NO;
                [self.indictorView startAnimating];
                if (self.target && [self.target respondsToSelector:self.selector]) {
                    [self.target performSelectorOnMainThread:self.selector withObject:@(FDRefreshStatePullUp) waitUntilDone:YES];
                }
            default:
                break;
        }
    };
    dispatch_async(dispatch_get_main_queue(), setStateBlock);
}

- (void)beginRefreshing {
    
    if (!self.oneNewPan) return;
    
    self.state = FDRefreshFooterViewStateRefreshing;
    self.oneNewPan = NO;
}

- (void)endRefreshing {
    self.state = FDRefreshFooterViewStateIdle;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        _scrollView = (id)newSuperview;
        self.backgroundColor = _scrollView.backgroundColor;
        
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
        [_scrollView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
        self.pan = _scrollView.panGestureRecognizer;
        [self.pan addObserver:self forKeyPath:@"state" options:options context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.state != FDRefreshFooterViewStateIdle || self.mcTop == 0 || self.hidden) {
            return;
        }
        if (self.scrollView.contentInset.top + self.scrollView.contentSize.height > self.scrollView.mcHeight) { // 内容超过一个屏幕
            if (self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - _scrollView.mcHeight - 20 + _scrollView.contentInset.bottom) {
                // 防止手松开时连续调用
                CGPoint old = [change[NSKeyValueChangeOldKey] CGPointValue];
                CGPoint new = [change[NSKeyValueChangeNewKey] CGPointValue];
                if (new.y <= old.y) return;
                
                // 当底部刷新控件完全出现时，才刷新
//                [self beginRefreshing];
            }
        }
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        self.mcTop = self.scrollView.contentSize.height;
        self.mcWidth = self.scrollView.contentSize.width;
    } else if ([keyPath isEqualToString:@"state"]) {
        if (self.state != FDRefreshFooterViewStateIdle || self.hidden) return;
        
        UIGestureRecognizerState panState = _scrollView.panGestureRecognizer.state;
        if (panState == UIGestureRecognizerStateEnded) {// 手松开
            if (_scrollView.contentInset.top + _scrollView.contentSize.height <= _scrollView.mcHeight) {  // 不够一个屏幕
                if (_scrollView.contentOffset.y >= - _scrollView.contentInset.top) { // 向上拽
                    [self beginRefreshing];
                }
            } else { // 超出一个屏幕
                if (_scrollView.contentOffset.y >= _scrollView.contentSize.height + _scrollView.contentInset.bottom - _scrollView.mcHeight) {
                    [self beginRefreshing];
                }
            }
        } else if (panState == UIGestureRecognizerStateBegan) {
            self.oneNewPan = YES;
        }
    }
}

@end
