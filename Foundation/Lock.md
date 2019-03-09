# 各种锁

# OSSpinLock

`OSSpinLock`是一种自旋锁

# dispatch_semaphore

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
