//
//  TIRouterActionCell.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TIRouterActionCell.h"
#import <Masonry/Masonry.h>

@implementation TIRouterActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor ti_background2];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(12);
        }];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.textColor = [UIColor ti_special];
        self.descLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
        }];
    }
    return self;
}

@end
