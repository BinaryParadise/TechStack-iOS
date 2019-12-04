//
//  NLWBAccountViewController.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import "NLWBAccountViewController.h"
#import "../View/NLWBAccountView.h"
#import "NLWeibo-Bridging-Header.h"
#import <Masonry/Masonry.h>

@interface NLWBAccountViewController () <NLWBAccountViewDelegate>

@property (nonatomic, strong) NLWBAccountView *accountView;


@end

@implementation NLWBAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.accountView = [[NLWBAccountView alloc] init];
    self.accountView.delegate = self;
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.accountView fillWithViewModel:[[WBAccountViewModel alloc] initWithAuthData:[self.presenter authData]]];
}

#pragma mark - NLWBAccountViewDelegate

- (void)willClearAuthData {
    [self.presenter clearAuthData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
