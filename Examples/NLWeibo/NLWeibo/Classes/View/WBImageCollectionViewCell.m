//
//  WBImageCollectionViewCell.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/15.
//

#import "WBImageCollectionViewCell.h"

@implementation WBImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
