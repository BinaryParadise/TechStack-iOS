//
//  NLViewController.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLViewController.h"

@implementation NLViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MCHexColor(0xF6F6F6);
}

@end
