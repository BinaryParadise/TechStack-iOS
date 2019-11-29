## 各种锁

## OSSpinLock

`OSSpinLock`是一种自旋锁，性能最好

>  [不再安全的OSSpinLock](http://www.cocoachina.com/articles/18088)
>
> 具体来说，如果一个低优先级的线程获得锁并访问共享资源，这时一个高优先级的线程也尝试获得这个锁，它会处于 spin lock 的忙等状态从而占用大量 CPU。此时低优先级线程无法与高优先级线程争夺 CPU 时间，从而导致任务迟迟完不成、无法释放 lock。这并不只是理论上的问题，libobjc 已经遇到了很多次这个问题了，于是苹果的工程师停用了 OSSpinLock。》优先级反转
>
> 建议使用dispatch_semaphore

## os_unfair_lock

是一个互斥锁，使用方式和自旋锁类似

```objc
//初始化
os_unfair_lock oslock = OS_UNFAIR_LOCK_INIT;

//获取锁，等待解锁后继续执行
os_unfair_lock_lock(&oslock);

//尝试获得锁，不等待继续往下执行
os_unfair_lock_trylock(&oslock);
  
//解锁
os_unfair_lock_unlock(&oslock);
```



## 信号量

### dispatch_semaphore_create

```objc
//通过给定一个不小于0初始值（`0表示无信号`）创建新的计数信号量，创建失败返回`NULL`
dispatch_semaphore_t dispatch_semaphore_create(long value);
```

### dispatch_semaphore_wait

>  等待信号量
>  信号量`>=1`时，计数`减1`，继续往下执行
>  信号量`=0`时，线程在超时时间内等待，到期后继续向下执行
>  成功返回0，等待超时返回非0

```objc
long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout);
```

### dispatch_semaphore_signal

> 增加一个信号量，如果之前的信号量小于0，则此函数返回之前唤醒等待的线程
> `当返回0时`：表示无线程等待，信号加1。
> `当返回非0时`：表示当前有一个或多个线程线程等待，并且该函数唤醒了一个“等待的线程”（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）。
```objc
long dispatch_semaphore_signal(dispatch_semaphore_t dsema);
```

## pthread_mutex

C语言实现的互斥锁

```c
pthread_mutex_t _mutex;
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr);
//PTHREAD_MUTEX_RECURSIVE递归锁
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
//初始化锁
pthread_mutex_init(&_mutex, &attr);
//加锁，成功才会继续执行，否则等待解锁
pthread_mutex_lock(&_mutex)
//解锁
pthread_mutex_unlock(&_mutex);
```

## @synchronized

使用的是递归互斥锁

## NSLock

> `NSLock`通过实现NSLocking协议实现了一种简单的互斥锁，面向对象

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
- (BOOL)lockBeforeDate:(NSDate *)limit;
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

## NSCondition

**NSCondition 的对象**实际上**作为一个锁**和一个**线程检查器**：锁主要为了当检测条件时保护数据源，执行条件引发的任务；线程检查器主要是**根据条件决定是否继续运行线程，即线程是否被阻塞。**

## NSConditionLock 条件锁

在指定条件时可获得锁

解锁指定条件

## NSRecursiveLock 递归锁

NSRecursiveLock实际上定义的是一个递归锁，这个锁可以被同一线程多次请求，而不会引起死锁。这主要是用在循环或递归操作中。它可以允许同一线程多次加锁，而不会造成死锁。递归锁会跟踪它被lock的次数。每次成功的lock都必须平衡调用unlock操作。只有所有达到这种平衡，锁最后才能被释放，以供其它线程使用。