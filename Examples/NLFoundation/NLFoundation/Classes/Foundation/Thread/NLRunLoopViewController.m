//
//  NLRunLoopViewController.m
//  NLFoundation
//
//  Created by Rake Yang on 2019/12/5.
//

#import "NLRunLoopViewController.h"

@interface NLRunLoopViewController ()

@end

@implementation NLRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self runloop0];
}

/**
 默认主线程
 */
- (void)runloop0 {
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NLLogDebug(@"%p %@", CFRunLoopGetCurrent(), [NSThread currentThread]);
    }];
    [timer fire];
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
