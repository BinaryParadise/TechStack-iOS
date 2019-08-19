//
//  MemoryViewController.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/8.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "MemoryViewController.h"
#import "MemoryConstruction.h"
#import <TIRouterAction/TIRouterAction.h>

@interface MemoryViewController ()

@property (nonatomic, strong) MemoryConstruction *memoryConstruct;

@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.memoryConstruct = [MemoryConstruction new];
    [self.memoryConstruct testMethod:19999 str:@"000000000000000"];
    MCLogWarn(@"%@", self.memoryConstruct);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
