//
//  JSNSArrayViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLMCCollectionActions.h"
#import "NSMutableArray+JSSafety.h"
#import "NLNSArrayViewController.h"

#define MACH_TIME_START    NSDate *startDate = [NSDate date];\

#define MACH_TIME_END(fmt)   NLLogWarn(fmt @"耗时：%.3fs", [NSDate date].timeIntervalSince1970 - startDate.timeIntervalSince1970);

static NSMutableArray *_marr;
@interface NLMCCollectionActions ()

@end

@implementation NLMCCollectionActions

+ (void)unsafeArray:(PGRouterContext *)context {
    [self safeArray:context];
}

+ (void)safeArray:(PGRouterContext *)context {
    // Do any additional setup after loading the view.
    NSMutableArray *marr = [NSMutableArray array];

    MACH_TIME_START
    for (NSInteger i=0; i< 65535 * 1000; i++) {
        [marr addObject:@(i)];
    }
    MACH_TIME_END(@"构造数据")

    _marr = marr;

    __block BOOL running = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MACH_TIME_START
        __block BOOL show = YES;
        if ([context.userInfo mc_boolForKey:@"safe"]) {
            [marr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!running && show) {
                    NLLogWarn(@"%@", obj);
                    show = NO;
                }
            }];
        } else {
            @try {
                //不要直接遍历NSMutableArray
                for (id obj1 in marr) {//遍历的同时元素被修改导致crash
                    if (!running && show) {
                        NLLogWarn(@"%@", obj1);
                        show = NO;
                    }
                }
            } @catch (NSException *exception) {
                NLLogError(@"%@", exception);
            } @finally {
                
            }
            
        }
        MACH_TIME_END(@"遍历完成")
        [context finished];
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NLLogDebug(@"休眠");
        [NSThread sleepForTimeInterval:0.2];
        NLLogDebug(@"取消");
        running = NO;
        NLLogInfo(@"遍历移除数组元素[52428000-58981500]");
        for (NSUInteger i=65535*800; i<=65535*900; i++) {
            [marr removeObjectAtIndex:i];
        }
        NLLogDebug(@"移除完成...");
    });
}

+ (void)uiDemo:(PGRouterContext *)context {
    UIViewController *vc = [[NLNSArrayViewController alloc] initWithNibName:nil bundle:nil];
    [self pushViewController:vc animated:YES];
    [context finished];
}

@end
