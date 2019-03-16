//
//  PGPageViewController.m
//  iOSGuide
//
//  Created by joengzi on 2019/3/4.
//  Copyright © 2019年 mylcode. All rights reserved.
//

#import "UKPageViewController.h"

@interface UKPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation UKPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *marr = [NSMutableArray array];
    for (NSUInteger i=0; i<5; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithWhite:i/5.0 alpha:0.9];
        [marr addObject:vc];
    }

    self.viewControllers = marr;
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.pageViewController.doubleSided = YES;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController setViewControllers:@[self.viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    return index == 0 ? nil : [self.viewControllers objectAtIndex:index-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    return index == self.viewControllers.count - 1 ? nil : [self.viewControllers objectAtIndex:index+1];
}

@end
