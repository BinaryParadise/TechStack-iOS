//
//  SNViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "SNViewController.h"

@interface SNViewController ()

@property (nonatomic, copy) NSDictionary *config;

@end

@implementation SNViewController

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _config = dict;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNumber *bgcolor = _config[@"backgroundColor"];
    self.view.backgroundColor = [UIColor colorWithHex:[bgcolor longValue]];
}

@end
