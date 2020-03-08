//
//  NLVPSInfoTableViewCell.m
//  Neverland
//
//  Created by Rake Yang on 2020/3/1.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "NLVPSInfoTableViewCell.h"

@implementation NLVPSInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:15];
    self.contentLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
