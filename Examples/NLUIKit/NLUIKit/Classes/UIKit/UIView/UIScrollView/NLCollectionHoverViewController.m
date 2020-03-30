//
//  NLCollectionHoverViewController.m
//  NLUIKit
//
//  Created by Rake Yang on 2020/3/24.
//

#import "NLCollectionHoverViewController.h"
#import "NLHoverFlowLayout.h"

@interface NLCollectionHoverViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation NLCollectionHoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NLHoverFlowLayout *flowLayout = [NLHoverFlowLayout new];
    flowLayout.contentInset = 56;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 135);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"xxx"];
    [self.collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xxxx0"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 10: 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"xxx" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section != 1) {
        return CGSizeZero;
    }
    return CGSizeMake(self.view.frame.size.width, 64);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xxxx0" forIndexPath:indexPath];
    view.backgroundColor = [UIColor grayColor];
    return view;
}

@end
