//
//  JSFloatNumberViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "JSFloatNumberViewController.h"

@interface JSFloatNumberViewController ()

@end

@implementation JSFloatNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self processFloat];
}

- (void)processFloat {
    NSString *jsonStr = @"{\"price\":71.49}";
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSNumber *price = dict[@"price"];
    NSString *priceStr = [NSString stringWithFormat:@"%lf", price.doubleValue];
    NSLog(@"处理之前：%@，=? %d", [price stringValue], [priceStr isEqualToString:@"71.49"]);
    
    NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:price.stringValue];
    NSLog(@"处理之后：%@", [decimalPrice stringValue]);
}

@end
