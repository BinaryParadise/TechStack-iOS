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
        NLLogDebug(@"壹 %@", self);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NLLogDebug(@"贰 %@", self);
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NLLogDebug(@"肆 %@", self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NLLogDebug(@"叁 %@", self);
}

- (void)dealloc {
    NLLogWarn(@"释放 %@", self);
}

@end
