//
//  NLRootCollectionViewController.m
//  Neverland
//
//  Created by Rake Yang on 2020/3/1.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "NLRootCollectionViewController.h"
#import "NLActionCollectionCell.h"
#import "NLTitleCollectionReusableView.h"
#import "NLRouterViewController.h"
#import <NLModuleService/NLModuleService.h>

@interface NLRootCollectionViewController ()

@property (nonatomic, copy) NSArray *data;


@end

@implementation NLRootCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.data = @[@{@"icon":@"doraemon_h5",@"title":@"路由表"},
                  @{@"icon":@"icon_sina",@"title":@"微博"}];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"NLTitleCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NLActionCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NLActionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.data[indexPath.item][@"icon"]];
    cell.titleLabel.text = self.data[indexPath.item][@"title"];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header1" forIndexPath:indexPath];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        [self.navigationController pushViewController:NLRouterViewController.new animated:YES];
    } else if (indexPath.item == 1) {
        [self.navigationController pushViewController:NLM_Weibo.nativeController animated:YES];
    }
}

@end
