//
//  NLRunLoopViewController.m
//  NLFoundation
//
//  Created by Rake Yang on 2019/12/5.
//

#import "NLRunLoopViewController.h"
#import <NLUtility/NLUtility.h>

@interface NLRunLoopViewController ()

@property (nonatomic, weak) IBOutlet UILabel *defaultLabel;
@property (nonatomic, weak) IBOutlet UILabel *trackingLabel;
@property (nonatomic, weak) IBOutlet UILabel *commondLabel;
@property (nonatomic, weak) IBOutlet UILabel *sourceLabel;

@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation NLRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self runloopDefault];
    [self runloopTracking];
    [self runloopCommonds];
    [self runloopSource];
    [self runLoopObserver];
}

/**
 主线程：默认模式
 */
- (void)runloopDefault {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod:) userInfo:self.defaultLabel repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

/**
 UI捕获：只在接收触摸事件时才被触发
 */
- (void)runloopTracking {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod:) userInfo:self.trackingLabel repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}

/**
 公共模式：都会触发
 */
- (void)runloopCommonds {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod:) userInfo:self.commondLabel repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
}

/**
 事件源
 source0: 用户事件
 source1: 系统内核事件
 */
- (void)runloopSource {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sourceLabel.text = [[NSDate date] localTimeString];
        });
    });
    dispatch_resume(timer);
    self.timer = timer;
}

/**
 RunLoop观察者
 */
- (void)runLoopObserver {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    //定义观察者
    static CFRunLoopObserverRef defaultModeObserver;
    
    //上下文
    CFRunLoopObserverContext observerContext = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    //创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &observerCallback, &observerContext);
    
    //添加到RunLoop中
    CFRunLoopAddObserver(runLoop, defaultModeObserver, kCFRunLoopDefaultMode);
}

- (void)timerMethod:(NSTimer *)timer {
    NLLogDebug(@"%@", [NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = timer.userInfo;
        label.text = [[NSDate date] localTimeString];
    });
}

void observerCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NLRunLoopViewController *vc = (__bridge NLRunLoopViewController *)info;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
