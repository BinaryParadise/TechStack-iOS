//
//  GDRouterTableViewCell.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/15.
//  Copyright © 2019 joengzi. All rights reserved.
//

#import "GDRouterTableViewCell.h"

IB_DESIGNABLE
@implementation GDRouterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.text = self.title;
}

@end
