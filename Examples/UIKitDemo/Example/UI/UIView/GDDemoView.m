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
    LogDebug(@"壹")
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    LogDebug(@"贰")
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    LogDebug(@"肆")
}

- (void)layoutSubviews {
    [super layoutSubviews];
    LogDebug(@"叁")
}

- (void)dealloc {
    LogWarn(@"释放")
}

@end
