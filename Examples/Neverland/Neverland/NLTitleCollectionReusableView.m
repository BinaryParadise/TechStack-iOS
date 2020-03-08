//
//  NLTitleCollectionReusableView.m
//  Neverland
//
//  Created by Rake Yang on 2020/3/1.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "NLTitleCollectionReusableView.h"

@implementation NLTitleCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName:@"Menlo-BoldItalic" size:22];
}

@end
