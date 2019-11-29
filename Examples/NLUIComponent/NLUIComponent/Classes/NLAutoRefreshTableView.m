//
//  NLAutoRefreshTableView.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLAutoRefreshTableView.h"
#import <objc/runtime.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>
#import <Masonry/Masonry.h>

@implementation NLAutoRefreshTableView

- (void)setContentSize:(CGSize)contentSize {
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero) && !self.isRefreshing) {
        //内容变多时且超过一屏自动增加偏移，就不会回弹（下拉处理逻辑不同）
        if (self.contentOffset.y - self.mcHeight > self.contentSize.height && contentSize.height > self.contentSize.height) {
            CGPoint point = self.contentOffset;
            point.y += (contentSize.height - self.contentSize.height);
            self.contentOffset = point;
        }
    }
    [super setContentSize:contentSize];
//    DDLogDebug(@"%@", NSStringFromCGSize(contentSize));
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    DDLogDebug(@"之前：%@", NSStringFromUIEdgeInsets(contentInset));
    [super setContentInset:contentInset];
    DDLogDebug(@"之后：%@", NSStringFromUIEdgeInsets(contentInset));
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
//    DDLogWarn(@"%@", NSStringFromCGPoint(contentOffset));
}

- (BOOL)isRefreshing {
    return self.fd_footer.state == FDRefreshFooterViewStateRefreshing;
}

@end

@implementation UITableView (FDRefresh)

- (void)setFd_footer:(NLRefreshFooterView *)fd_footer {
    [self insertSubview:fd_footer atIndex:0];
    objc_setAssociatedObject(self, @selector(fd_footer), fd_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NLRefreshFooterView *)fd_footer {
    return objc_getAssociatedObject(self, _cmd);
}

@end
