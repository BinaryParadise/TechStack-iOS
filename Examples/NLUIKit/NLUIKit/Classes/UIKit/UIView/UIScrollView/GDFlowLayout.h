//
//  GDFlowLayout.h
//  UIKitDemo
//
//  Created by Rake Yang on 2020/1/5.
//  Copyright © 2020年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义布局
 */
@interface GDFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat maximumLineSpacing;
@property (nonatomic) CGFloat maximumInteritemSpacing;

@end

NS_ASSUME_NONNULL_END
