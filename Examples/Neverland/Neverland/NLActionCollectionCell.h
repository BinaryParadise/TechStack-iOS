//
//  NLActionCollectionCell.h
//  Neverland
//
//  Created by Rake Yang on 2020/3/1.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLActionCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
