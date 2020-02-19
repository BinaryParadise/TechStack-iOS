//
//  GDUICollectionViewController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2020/1/1.
//  Copyright © 2020年 BinaryParadise. All rights reserved.
//

#import "GDUICollectionViewController.h"
#import <MCUIKit/MCUIKit.h>
#import "GDFlowLayout.h"
#import <Masonry/Masonry.h>

@interface _GDCollectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation _GDCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"Header1";
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

@end

@interface _GDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation _GDCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [MCHexColor(0x0) colorWithAlphaComponent:0.08];
        self.layer.cornerRadius = 4;
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = MCHexColor(0x333333);
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(3);
            make.right.equalTo(self.contentView).offset(-3);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end

@interface GDUICollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *datas;


@end

@implementation GDUICollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MCHexColor(0xF6F6F6);
    
    self.datas = @[@[@"杭州", @"中华人民共和国浙江省杭州市", @"浙江省杭州市", @"杭州市"],
                   @[@"16GB DDR5", @"64 GB DDR5"],
                   @[@"国行"]];
    
    GDFlowLayout *flowLayout = [[GDFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.maximumLineSpacing = 8;
    flowLayout.maximumInteritemSpacing = 8;
    
    //关键2：通过自动布局预估布局
//    flowLayout.estimatedItemSize = CGSizeMake(180.0, 16.0);
    flowLayout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.layer.cornerRadius = 4;
    self.collectionView.backgroundColor = [UIColor whiteColor];
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
    [self.collectionView registerClass:_GDCollectionHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(_GDCollectionHeaderView.class)];
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

// Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    _GDCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(_GDCollectionHeaderView.class) forIndexPath:indexPath];
    return headerView;
}

// 每一项的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tag = self.datas[indexPath.section][indexPath.row];
    CGSize size = [tag boundingRectWithSize:CGSizeMake(200.0, 20.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    return CGSizeMake(ceil(size.width) + 6, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 20.0);
}

@end
