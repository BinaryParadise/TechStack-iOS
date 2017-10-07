//
//  ViewController.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "ViewController.h"
#import "GCDDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[GCDDemo asyncConcurrent];
    //[GCDDemo asyncSerial];
    //[GCDDemo syncConcurrent];
    //[GCDDemo syncSerial];
    [GCDDemo syncMain];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
