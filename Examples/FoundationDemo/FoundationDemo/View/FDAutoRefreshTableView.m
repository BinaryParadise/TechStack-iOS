//
//  FDAutoRefreshTableView.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDAutoRefreshTableView.h"
#import <objc/runtime.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import <Masonry/Masonry.h>

@implementation FDAutoRefreshTableView

- (void)setContentSize:(CGSize)contentSize {
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero)) {
        //内容变多时自动增加偏移，就不会回弹
        if (contentSize.height > self.contentSize.height) {
            CGPoint offset = self.contentOffset;
            offset.y += MAX(contentSize.height - self.contentSize.height, 0);
            self.contentOffset = offset;
        }
    }
    [super setContentSize:contentSize];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
}

@end

@interface FDRefreshFooterView ()

@property (nonatomic, strong) UIActivityIndicatorView *indictorView;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

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
    void(^setStateBlock)() = ^() {
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
                    [self.target performSelectorOnMainThread:self.selector withObject:nil waitUntilDone:YES];
                }
            default:
                break;
        }
    };
    dispatch_async(dispatch_get_main_queue(), setStateBlock);
}

- (void)beginRefreshing {
    self.state = FDRefreshFooterViewStateRefreshing;
}

- (void)endRefreshing {
    self.state = FDRefreshFooterViewStateIdle;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        _scrollView = (id)newSuperview;
        self.mcTop = _scrollView.contentSize.height;
        self.mcWidth = _scrollView.contentSize.width;
        self.backgroundColor = _scrollView.backgroundColor;
        //TODO: observe
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // 内容的高度
        CGFloat contentHeight = self.scrollView.contentSize.height;
        // 表格的高度
        CGFloat scrollHeight = self.scrollView.mcHeight;
        // 设置位置和尺寸
        self.mcTop = MAX(contentHeight, scrollHeight);
        if (self.scrollView.contentOffset.y + self.scrollView.contentSize.height > self.scrollView.mcHeight - 10 && self.state != FDRefreshFooterViewStateRefreshing) {
            [self beginRefreshing];
        }
    }
}

@end

@implementation UITableView (FDRefresh)

- (void)setFd_footer:(FDRefreshFooterView *)fd_footer {
    [self insertSubview:fd_footer atIndex:0];
    objc_setAssociatedObject(self, @selector(fd_footer), fd_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FDRefreshFooterView *)fd_footer {
    return objc_getAssociatedObject(self, _cmd);
}

@end
