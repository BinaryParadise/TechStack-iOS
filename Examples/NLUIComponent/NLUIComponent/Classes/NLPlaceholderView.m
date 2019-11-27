//
//  NLPlaceholderView.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/4.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLPlaceholderView.h"
#import <Masonry/Masonry.h>

@interface NLPlaceholderView ()

@property (nonatomic, strong) UIButton *retryButton;


@end

@implementation NLPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _retryButton.backgroundColor = MCHexColor(0xEE5023);
        _retryButton.layer.cornerRadius = 5;
        _retryButton.layer.masksToBounds = YES;
        _retryButton.contentEdgeInsets = UIEdgeInsetsMake(10, 50, 10, 50);
        [_retryButton setTitle:@"重试" forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_retryButton];
        [_retryButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - Actions

- (void)retryButtonClick:(UIButton *)button {
    if (self.onButtonClick) {
        self.onButtonClick();
    }
}

@end
