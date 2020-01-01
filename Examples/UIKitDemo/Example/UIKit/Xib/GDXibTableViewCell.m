//
//  GDXibTableViewCell.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/7/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDXibTableViewCell.h"

@implementation GDXibTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        id nibInstance = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        self = nibInstance;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
