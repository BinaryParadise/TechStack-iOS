# 多线程

> 解决方案对比

| 方案 | 简介 | 语言 | 线程生命周期 | 使用频率 |
| --- | --- | --- | :---: | --- |
| pthread   | 一套通用的多线程API<br>适用unix/linux/Windows等<br/>跨平台、可移植</br>使用难度大  | C  | 手动  | 几乎不用  |
| NSThread  | 面向对象<br/>简单易用，可直接操作线程对象  | OC  | 手动  | 偶尔使用  |
| GCD  | 旨在替代NSThread等线程技术<br/>充分利用设备的多核  | C | 自动 | 经常使用  |
| NSOperation | 底层是GCD<br/>比GCD多一些简单实用的功能</br>更加面向对象  |  OC  | 自动  | 经常使用  |

## Pthreads

> POSIX线程（POSIX threads），简称Pthreads，是线程的POSIX标准。该标准定义了创建和操纵线程的一整套API。在类Unix操作系统（Unix、Linux、Mac OS X等）中，都使用Pthreads作为操作系统的线程。

通用多线程API，基于C语言框架，高移植性，iOS中基本不用

## NSThread

> 经苹果封装面向对象的线程操作类，需要我们手动管理它的生命周期.

```objc
// 创建线程
NSThread *thread = [[NSThread alloc] initWithBlock:threadBlock];
//启动线程
[thread start];
  
// 隐式创建并启动线程
[self performSelectorInBackground:@selector(run) withObject:nil];
```

### 类方法&属性

```objc
//当前线程，number=1，name=main表示主线程
@property (class, readonly, strong) NSThread *currentThread;

//休眠2秒
[NSThread sleepForTimeInterval:2];

//休眠到指定时间，2秒后
[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];

//退出线程
[NSThread exit];

//判断当前线程是否为主线程
[NSThread isMainThread];

//判断当前线程是否是多线程
[NSThread isMultiThreaded];

//主线程的对象
[NSThread mainThread];
```

### 示例方法&属性

> 详见<Foundation/NSThread.h>

## GCD

> `在主队列中执行同步任务会造成*DeadLock*`

| 执行方式 | 并行队列 | 串行队列 | 主队列 |
| ---- | ---- | ---- | ---- |
| 异步执行 | 开启多个线程，任务同步执行 | 开启一个新线程，任务按顺序执行 | 在主线程按顺序执行任务 |
| 同步执行 | 不开启线程，按顺序在主线程执行任务 | 在主线程按顺序执行任务 | DealLock |

### 主队列

```objc
dispatch_get_main_queue();
```

### 串行队列

```objc
dispatch_queue_create("queue_serial", DISPATCH_QUEUE_SERIAL)
```

### 并行队列

```objc
dispatch_queue_create("queue_concurrent", DISPATCH_QUEUE_CONCURRENT)
```

### 全局并行队列

```objc
dispatch_get_global_queue(0, 0);
```

## 栅栏

> 当任务需要异步进行，但是这些任务需要分成两组来执行，第一组完成之后才能进行第二组的操作。这时候就用了到GCD的栅栏方法dispatch_barrier_async
>
> dispatch_barrier_sync会在主线程执行，后续任务需要等待
>
> 在使用栅栏函数时.使用自定义队列才有意义,如果用的是串行队列或者系统提供的全局并发队列,这个栅栏函数的作用等同于一个同步函数的作用

```objc
dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
dispatch_async(queue3, ^{
    for (int i=0; i<3; i++) {
        LogDebug(@"栅栏并发异步1-%d %@", i, [NSThread currentThread]);
    }
});
dispatch_async(queue3, ^{
    for (int i=0; i<3; i++) {
        LogDebug(@"栅栏并发异步2-%d %@", i, [NSThread currentThread]);
    }
});

dispatch_barrier_async(queue3, ^{
    LogDebug(@"---------barrier---------%@", [NSThread currentThread]);
});

dispatch_async(queue3, ^{
    for (int i=0; i<3; i++) {
        LogDebug(@"栅栏并发异步3-%d %@", i, [NSThread currentThread]);
    }
});
dispatch_async(queue3, ^{
    for (int i=0; i<3; i++) {
        LogDebug(@"栅栏并发异步4-%d %@", i, [NSThread currentThread]);
    }
});
```

### dispatch_after（延时执行）

> dispatch_after

### dispatch_apply（快速迭代）

> dispatch_apply按指定的次数将指定的block追加到指定的队列中，并等待全部处理执行结束，好处是可以重复执行某项操作并复用我们的block了
>
> 第一个参数为重复次数；
> 第二个参数为追加对象的Dispatch Queue；
> 第三个参数为追加的操作，追加的Block中带有参数，这是为了按第一个参数重复追加Block并区分各个Block而使用。

```objc
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

//在全局队列queue上执行十次输出操作
dispatch_apply(10, queue, ^(size_t index) {
    LogDebug(@"%zu", index);
});

LogDebug(@"done!");
```

### 队列分组

```objc
dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        LogDebug(@"队列分组异步1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        LogDebug(@"队列分组异步2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        LogDebug(@"队列分组异步3 %@", [NSThread currentThread]);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        LogDebug(@"队列分组任务全部执行完成 %@", [NSThread currentThread]);
    });
```



## NSOperation

> 基于GCD更高级的封装，更加面向对象
>
> 支持添加依赖操作



## RunLoop

> 是一种“闲”等待的循环，有事件的时候去寻找handler处理，没有事件时进入休眠。

下图中展现了 Runloop 在线程中的作用：从 input source 和 timer source 接受事件，然后在线程中处理事件。

![](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Multithreading/Art/runloop.jpg)



- 每个线程对应一个Runloop，App启动时主线程的RunLoop完成启动

### Input Source 和 Timer Source

其中 Input Source 又可以分为三类

	* Port-Based Sources，系统底层的 Port 事件，例如 CFSocketRef ，在应用层基本用不到

- Custom Input Sources，用户手动创建的 Source
- Cocoa Perform Selector Sources， Cocoa 提供的 performSelector 系列方法，也是一种事件源

Timer Source

​	- 明显就是指计时器事件

### Runloop Observer

Runloop 通过监控 Source 来决定有没有任务要做，除此之外，我们还可以用 Runloop Observer 来监控 Runloop 本身的状态。 Runloop Observer 可以监控下面的 runloop 事件：

- The entrance to the run loop.
- When the run loop is about to process a timer.
- When the run loop is about to process an input source.
- When the run loop is about to go to sleep.
- When the run loop has woken up, but before it has processed the event that woke it up.
- The exit from the run loop.

### Runloop Mode

在监视与被监视中，Runloop 要处理的事情还挺复杂的。为了让 Runloop 能专心处理自己关心的那部分事情，引入了 Runloop Mode 概念。

![Runloop Mode](http://cc.cocimg.com/api/uploads/20150528/1432798883604537.png)

如图所示，Runloop Mode 实际上是 Source，Timer 和 Observer 的集合，不同的 Mode 把不同组的 Source，Timer 和 Observer 隔绝开来。Runloop 在某个时刻只能跑在一个 Mode 下，处理这一个 Mode 当中的 Source，Timer 和 Observer。

苹果文档中提到的 Mode 有五个，分别是：

- NSDefaultRunLoopMode
- ~~NSConnectionReplyMode~~
- ~~NSModalPanelRunLoopMode~~
- ~~NSEventTrackingRunLoopMode~~
- NSRunLoopCommonModes

iOS 中公开暴露出来的只有 NSDefaultRunLoopMode 和 NSRunLoopCommonModes。 NSRunLoopCommonModes 实际上是一个 Mode 的集合，默认包括 NSDefaultRunLoopMode 和 NSEventTrackingRunLoopMode。

### 与 Runloop 相关的坑

日常开发中，与 runLoop 接触得最近可能就是通过 NSTimer 了。一个 Timer 一次只能加入到一个 RunLoop 中。我们日常使用的时候，通常就是加入到当前的 runLoop 的 default mode 中，而 ScrollView 在用户滑动时，主线程 RunLoop 会转到 UITrackingRunLoopMode 。而这个时候， Timer 就不会运行。

有如下两种解决方案：

- 第一种: 设置 RunLoop Mode，例如 NSTimer,我们指定它运行于 NSRunLoopCommonModes ，这是一个 Mode 的集合。注册到这个 Mode 下后，无论当前 runLoop 运行哪个 mode ，事件都能得到执行。
- 第二种: 另一种解决 Timer 的方法是，我们在另外一个线程执行和处理 Timer 事件，然后在主线程更新 UI。