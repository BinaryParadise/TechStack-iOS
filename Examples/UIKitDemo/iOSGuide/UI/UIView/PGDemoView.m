//
//  PGDemoView.m
//  iOSGuide
//
//  Created by joengzi on 2019/1/6.
//  Copyright © 2019年 mylcode. All rights reserved.
//

#import "PGDemoView.h"

@implementation PGDemoView

- (instancetype)init {
    LogInfo(@"壹")
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    LogInfo(@"贰")
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    LogInfo(@"肆")
}

- (void)layoutSubviews {
    [super layoutSubviews];
    LogInfo(@"叁")
}

- (void)dealloc {
    LogInfo(@"终")
}

@end
