//
//  NLWeiboTableViewCell.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLWeiboTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NLWeiboTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatorView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *sourceLabel;
@property (nonatomic, strong) NLWBStatusViewModel *viewModel;


@end

@implementation NLWeiboTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatorView.layer.cornerRadius = 40/2.0;
    self.avatorView.layer.masksToBounds = YES;
}

- (void)fillWithViewModel:(NLWBStatusViewModel *)viewModel {
    _viewModel = viewModel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.avatar]];
    self.nameLabel.text = self.viewModel.screen_name;
    self.timeLabel.text = self.viewModel.createdStr;
    self.sourceLabel.text = self.viewModel.source;
    self.contentLabel.text = self.viewModel.text;
}

+ (CGFloat)defaultHeightForData:(NLFWBStatus *)data {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 4;
    paragraph.minimumLineHeight = 20;
    
    CGFloat textH = [data.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraph} context:nil].size.height;
    DDLogWarn(@"%f", textH);
    return 16 + 40 + 16 + MIN(textH, 8*24) + 8;
}

@end
