//
//  MCDemoTableViewCell.m
//  FoundationDemo
//
//  Created by joengzi on 2019/3/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCDemoTableViewCell.h"

@implementation MCDemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
