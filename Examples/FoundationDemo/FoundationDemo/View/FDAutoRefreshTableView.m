//
//  FDAutoRefreshTableView.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDAutoRefreshTableView.h"

@implementation FDAutoRefreshTableView

- (void)setContentSize:(CGSize)contentSize {
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero)) {
        //内容变多时自动增加偏移，就不会回弹
        if (contentSize.height > self.contentSize.height) {
            CGPoint offset = self.contentOffset;
            offset.y += (contentSize.height - self.contentSize.height);
            self.contentOffset = offset;
        }
    }
    [super setContentSize:contentSize];
}

@end
