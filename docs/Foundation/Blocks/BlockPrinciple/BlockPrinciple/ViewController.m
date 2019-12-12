//
//  ViewController.m
//  BlockPrinciple
//
//  Created by Rake Yang on 2019/12/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "ViewController.h"
#import "IceBox.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int a = 10;
    int(^myBlock)(id) = ^(id obj) {
        NSLog(@"%d %@", a, obj);
        return 0;
    };
    
    myBlock([IceBox new]);
    NSLog(@"%@", myBlock);
}

@end
