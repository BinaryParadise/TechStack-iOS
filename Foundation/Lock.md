# 各种锁

# OSSpinLock

`OSSpinLock`是一种自旋锁

# 信号量

## dispatch_semaphore_create

> 通过给定初始值创建新的计数信号量创建失败返回`NULL`，`0`表示无信号
```objc
dispatch_semaphore_t dispatch_semaphore_create(long value);
```

## dispatch_semaphore_wait

>  等待或减少一个信号量
信号量`>=1`时，计数`减1`，继续往下执行，返回值为`0`
信号量`=0`时，线程在超时时间内阻塞，到期后继续向下执行，返回值为非`0`

```objc
long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout);
```

> 增加一个信号量，如果之前的信号量小于0，则次函数返回之前唤醒等待的线程
> 如果线程被唤醒返回非0值，否则返回0

## dispatch_semaphore_signal

> `当返回值为0时`：表示无线程等待，信号加1。
`当返回值不为0时`：表示当前有一个或多个线程线程等待，并且该函数唤醒了一个“等待的线程”（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）。
```objc
long dispatch_semaphore_signal(dispatch_semaphore_t dsema);
```

# pthread_mutex

# @synchronized

# NSLock

> `NSLock`通过实现NSLocking协议实现了一种简单的互斥锁

```objc
@protocol NSLocking

- (void)lock;
- (void)unlock;

@end

```

```objc
/**
  尝试获取锁并立即返回一个布尔值，该值表示获取是否成功。（非阻塞线程）
*/
- (BOOL)tryLock;

/**
  尝试在给定时间之前获取锁，并返回一个布尔值，该值表示获取是否成功。（阻塞线程）
*/
- (BOOL)lockBeforeDate:(NSDate \*)limit;
```

> 举个卖iPhone的例子

`加锁`

```objc
03-09 12:15:34:944+0800 ◦ 剩余iPhone= 4，<NSThread: 0x600000e98440>{number = 4, name = (null)}
03-09 12:15:34:944+0800 ◦ 剩余iPhone= 3，<NSThread: 0x600000e983c0>{number = 5, name = (null)}
03-09 12:15:34:944+0800 ◦ 剩余iPhone= 2，<NSThread: 0x600000e983c0>{number = 5, name = (null)}
03-09 12:15:34:944+0800 ◦ 剩余iPhone= 1，<NSThread: 0x600000e983c0>{number = 5, name = (null)}
03-09 12:15:34:944+0800 ◦ 剩余iPhone= 0，<NSThread: 0x600000e98440>{number = 4, name = (null)}
03-09 12:15:34:944+0800 ◦ iPhone卖光了 <NSThread: 0x600000e983c0>{number = 5, name = (null)}
```

`不加锁`：结果不确定
```objc
03-09 12:19:30:846+0800 ◦ 剩余iPhone= 4，<NSThread: 0x600001e80040>{number = 7, name = (null)}
03-09 12:19:30:846+0800 ◦ 剩余iPhone= 2，<NSThread: 0x600001e80040>{number = 7, name = (null)}
03-09 12:19:30:846+0800 ◦ 剩余iPhone= 1，<NSThread: 0x600001e80040>{number = 7, name = (null)}
03-09 12:19:30:846+0800 ◦ 剩余iPhone= 3，<NSThread: 0x600001e81cc0>{number = 8, name = (null)}
03-09 12:19:30:846+0800 ◦ iPhone卖光了 <NSThread: 0x600001e81cc0>{number = 8, name = (null)}
03-09 12:19:30:846+0800 ◦ 剩余iPhone= 0，<NSThread: 0x600001e80040>{number = 7, name = (null)}
03-09 12:19:30:846+0800 ◦ iPhone卖光了 <NSThread: 0x600001e80040>{number = 7, name = (null)}

```

# NSConditionLock 条件锁

# NSRecursiveLock 递归锁
