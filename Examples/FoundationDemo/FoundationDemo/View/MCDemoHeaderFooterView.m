//
//  MCDemoHeaderFooterView.m
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCDemoHeaderFooterView.h"
#import <Masonry/Masonry.h>
#import <MCUIKit/UIColor+MCExtension.h>

@interface MCDemoHeaderFooterView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MCDemoHeaderFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MCHexColor(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
