//
//  JSNSArrayViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "MCNSArrayActions.h"
#import "NSMutableArray+JSSafety.h"

static NSMutableArray *_marr;
@interface MCNSArrayActions ()

@end

@implementation MCNSArrayActions

+ (void)safeUse:(PGRouterContext *)context PGTarget("fd://NSArray/safeuse") {
    // Do any additional setup after loading the view.
    NSMutableArray *marr = [NSMutableArray array];

    MACH_TIME_START
    for (NSInteger i=0; i< 65535 * 1000; i++) {
        [marr addObject:@(i)];
    }
    MACH_TIME_END(@"造数据")

    _marr = marr;

    __block BOOL running = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MACH_TIME_START
        __block BOOL show = YES;
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
                MCLogWarn(@"%@", obj);
                show = NO;
            }
        }];
#endif
        MACH_TIME_END(@"遍历")
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MCLogWarn(@"休眠");
        [NSThread sleepForTimeInterval:0.2];
        MCLogWarn(@"取消");
        running = NO;
        for (NSUInteger i=65535*800; i<65535*900; i++) {
            [marr removeObjectAtIndex:i];
        }
    });
}

+ (NSUInteger)arrayCount {
    MCLogWarn(@"");
    return [_marr count];
}

@end
