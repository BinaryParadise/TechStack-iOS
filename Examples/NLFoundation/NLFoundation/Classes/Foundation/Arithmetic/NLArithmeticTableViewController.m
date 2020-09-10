//
//  NLMCArithmeticTableViewController.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/25.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLArithmeticTableViewController.h"
#import <NLUtility/NLUtility.h>
#import <Masonry/Masonry.h>

@interface NLArithmeticTableViewController ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *svrTimeLabel;

@end

@implementation NLArithmeticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = UIColor.whiteColor;
    
    //本地系统时间
    UILabel *timeLabel = [UILabel new];
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
    self.timeLabel = timeLabel;
        
    //服务器时间
    UILabel *svrTimeLabel = [UILabel new];
    [self.view addSubview:svrTimeLabel];
    [svrTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel);
        make.top.equalTo(timeLabel.mas_bottom).offset(20);
    }];
    self.svrTimeLabel = svrTimeLabel;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (IBAction)onTimer:(id)sender {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.timeLabel.text = [NSString stringWithFormat:@"本地时间 %@", [fmt stringFromDate:[NSDate date]]];
    self.svrTimeLabel.text = [NSString stringWithFormat:@"服务器时间 %@", [fmt stringFromDate:[NSDate serverDate]]];
}

@end
