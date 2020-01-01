//
//  PGDemoView.m
//  iOSGuide
//
//  Created by joengzi on 2019/1/6.
//  Copyright © 2019年 mylcode. All rights reserved.
//

#import "GDDemoView.h"

@implementation GDDemoView

- (instancetype)init {
    if (self = [super init]) {
        LogDebug(@"壹 %@", self)
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    LogDebug(@"贰 %@", self)
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    LogDebug(@"肆 %@", self)
}

- (void)layoutSubviews {
    [super layoutSubviews];
    LogDebug(@"叁 %@", self)
}

- (void)dealloc {
    LogWarn(@"释放 %@", self)
}

@end
