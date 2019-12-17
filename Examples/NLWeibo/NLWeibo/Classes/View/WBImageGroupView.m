//
//  WBImageGroupView.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/15.
//

#import "WBImageGroupView.h"
#import <NLUIComponent/NLUIComponent.h>
#import "WBImageCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface WBImageGroupView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<NSString *> *imageURLs;

@end

@implementation WBImageGroupView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setItemSize:imageSize];
}

- (void)configView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.imageSize;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [WBImageCollectionViewCell registerForCollectionView:self.collectionView];
}

- (void)fillWithImageURLs:(NSArray<NSString *> *)imageURLs {
    _imageURLs = imageURLs;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WBImageCollectionViewCell *cell = [WBImageCollectionViewCell cellForCollectionView:collectionView indexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[indexPath.row]]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.frame;
}

@end
