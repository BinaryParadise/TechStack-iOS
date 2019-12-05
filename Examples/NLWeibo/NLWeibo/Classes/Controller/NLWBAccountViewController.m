//
//  NLWBAccountViewController.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import "NLWBAccountViewController.h"
#import "NLWeibo-Bridging-Header.h"
#import <Masonry/Masonry.h>
#import <NLWeibo/NLWeibo-Swift.h>
#import "WBAccountViewModel.h"

@interface NLWBAccountViewController () <WBAccountViewDelegate>

@property (nonatomic, strong) WBAccountView *accountView;


@end

@implementation NLWBAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.accountView = [[WBAccountView alloc] init];
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
