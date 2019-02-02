//
//  JSNSArrayViewController.m
//  FoundationDemo
//
//  Created by lingjing on 2019/2/2.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "JSNSArrayViewController.h"
#import "NSMutableArray+JSSafety.h"

@interface JSNSArrayViewController ()

@property (nonatomic, strong) NSMutableArray *marr;

@end

@implementation JSNSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *marr = [NSMutableArray array];

    MACH_TIME_START
    for (NSInteger i=0; i< 65535 * 1000; i++) {
        [marr addObject:@(i)];
    }
    MACH_TIME_END(@"造数据")

    self.marr = marr;

    __block BOOL running = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MACH_TIME_START
        __block BOOL show = YES;
        NSUInteger count = marr.count;
        //不要直接遍历NSMutableArray
#if 0
        for (id obj1 in marr) {//crash
            if (!running && show) {
                LogWarn(@"%@", obj1);
                show = NO;
            }
        }
#endif
#if 1
        [marr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!running && show) {
                LogWarn(@"%@", obj);
                show = NO;
            }
        }];
#endif
        MACH_TIME_END(@"遍历")
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LogWarn(@"休眠");
        [NSThread sleepForTimeInterval:0.2];
        LogWarn(@"取消");
        running = NO;
        for (NSUInteger i=65535*800; i<65535*900; i++) {
            [marr removeObjectAtIndex:i];
        }
    });
}

- (NSUInteger)arrayCount {
    LogWarn(@"");
    return [self.marr count];
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
