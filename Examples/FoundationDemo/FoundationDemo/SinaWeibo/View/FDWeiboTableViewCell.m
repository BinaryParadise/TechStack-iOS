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
@property (nonatomic, weak) IBOutlet UILabel *sourceLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;


@end

@implementation FDWeiboTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatorView.layer.cornerRadius = 40/2.0;
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
    self.timeLabel.text = [self.status.created_at localTimeString];
    self.sourceLabel.text = self.status.source;
    self.contentLabel.text = self.status.text;
}

+ (CGFloat)defaultHeightForData:(FWBStatus *)data {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 4;
    paragraph.minimumLineHeight = 20;
    
    CGFloat textH = [data.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraph} context:nil].size.height;
    DDLogWarn(@"%f", textH);
    return 16 + 40 + 16 + MIN(textH, 8*24) + 8;
}

@end
