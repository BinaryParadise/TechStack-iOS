//
//  GDUICollectionViewController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2020/1/1.
//  Copyright © 2020年 BinaryParadise. All rights reserved.
//

#import "GDUICollectionViewController.h"

@interface _GDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation _GDCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.mas_lessThanOrEqualTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.mas_equalTo(@16);//设置高度固定则宽度自适应
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

// 关键1
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height = size.height;
//    layoutAttributes.frame = cellFrame;
//    return layoutAttributes;
//}

@end

@interface GDUICollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *datas;


@end

@implementation GDUICollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = @[@[@"杭州", @"中华人民共和国浙江省杭州市", @"杭州市", @"浙江省杭州市"],
  @[@"16GB DDR5", @"64 GB DDR5"]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 6;
    //关键2：通过自动布局预估布局
    flowLayout.estimatedItemSize = CGSizeMake(180.0, 16.0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 200) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(32);
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@256);
    }];
    
    [flowLayout invalidateLayout];
    [self.collectionView registerClass:_GDCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(_GDCollectionViewCell.class)];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.datas[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _GDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(_GDCollectionViewCell.class) forIndexPath:indexPath];
    [cell setTitle:self.datas[indexPath.section][indexPath.row]];
    return cell;
}

@end
