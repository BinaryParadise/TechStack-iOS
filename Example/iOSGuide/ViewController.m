//
//  ViewController.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "ViewController.h"
#import "TestModel1+Addition.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[TestModel1 new] testMethod];
    
    unsigned int outCount = 0;
    objc_property_t *proplist = class_copyPropertyList([TestModel1 class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = proplist[i];
        LogWarn(@"属性：%s", property_getName(property));
    }
    
    Ivar *ivars = class_copyIvarList([TestModel1 class], &outCount);
    for (int i=0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        LogWarn(@"字段：%s", ivar_getName(ivar));
    }
    
    Method *methods = class_copyMethodList([TestModel1 class], &outCount);
    for (int i=0; i<outCount; i++) {
        Method method = methods[i];
        LogWarn(@"方法：%@", NSStringFromSelector(method_getName(method)));
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
