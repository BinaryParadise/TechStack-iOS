//
//  FDWeiboTableViewCell.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDWeiboTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FDWeiboTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatorView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;


@end

@implementation FDWeiboTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatorView.layer.cornerRadius = 36/2.0;
    self.avatorView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:self.status.user.avatar_large]];
    self.nameLabel.text = self.status.user.screen_name;
    self.timeLabel.text = [self.status.created_at description];
}

@end
