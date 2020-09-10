//
//  PGRouteDefine.h
//  Peregrine
//
//  Created by Rake Yang on 2020/3/19.
//  Copyright © 2020 BinaryParadise. All rights reserved.

/**
  Generated automatic by Peregrine version 0.8.2 
  Don't modify manual ⚠️
*/

#import <Foundation/Foundation.h>

typedef NSString *PGRouterURLKey;

#pragma - mark helloworld

/// pg://helloworld
FOUNDATION_EXPORT PGRouterURLKey const pg_helloworld;


#pragma - mark Foundation

/// fd://Foundation/ARC?c=自动内存管理
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_ARC;

/// fd://Foundation/Category/Method?c=分类方法将被编译源文件列表中最后编译的覆盖
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Category_Method;

/// fd://Foundation/Category/initialize?c=objc_msgSend时调用
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Category_initialize;

/// fd://Foundation/Category/load?c=先编译先调用、父类早于子类调用、类和分类加载时调用
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Category_load;

/// fd://Foundation/Collection/NSArray/UI?c=页面展示
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Collection_NSArray_UI;

/// fd://Foundation/Collection/NSArray/safe?safe=1&c=安全使用
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Collection_NSArray_safe;

/// fd://Foundation/Collection/NSArray/unsafe?c=正常使用（不安全🔞）
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Collection_NSArray_unsafe;

/// fd://Foundation/DataType/Const
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_DataType_Const;

/// fd://Foundation/DataType/Float
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_DataType_Float;

/// fd://Foundation/GCD/Barrier/async?c=【并行队列】不等待插入任务完成继续加入任务
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Barrier_async;

/// fd://Foundation/GCD/Barrier/sync?c=【并行队列】等待插入任务执行完成后继续加入任务
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Barrier_sync;

/// fd://Foundation/GCD/Concurrent/async?c=异步:新线程执行，执行顺序不确定
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Concurrent_async;

/// fd://Foundation/GCD/Concurrent/sync?c=同步:主线程执行，按加入的先后顺序执行
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Concurrent_sync;

/// fd://Foundation/GCD/GlobalConcurrent/async?c=异步:新线程执行，顺序不确定（合适执行由优先级确定）
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_GlobalConcurrent_async;

/// fd://Foundation/GCD/GlobalConcurrent/sync?c=同步:主线程执行，按顺序执行
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_GlobalConcurrent_sync;

/// fd://Foundation/GCD/Group/concurrent?c=异步:并行队列新线程，顺序不确定，完成后通知
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Group_concurrent;

/// fd://Foundation/GCD/Group/serial?c=异步:串行队列新线程，按顺序执行，完成后通知
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Group_serial;

/// fd://Foundation/GCD/Main/async?c=异步:按顺序执行，耗时任务会造成阻塞
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Main_async;

/// fd://Foundation/GCD/Main/syncMain?c=🔞同步:互相等待造成死锁，抛出异常EXC_BAD_INSTRUCTION
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Main_syncMain;

/// fd://Foundation/GCD/Semaphore/create?c=使用信号量&use=1
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Semaphore_create;

/// fd://Foundation/GCD/Semaphore/normal?c=🔞不使用，会导致异常&use=0
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Semaphore_normal;

/// fd://Foundation/GCD/Serial/async?c=异步:开启新线程，按顺序执行
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Serial_async;

/// fd://Foundation/GCD/Serial/sync?c=同步:主线程执行，按顺序执行
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_GCD_Serial_sync;

/// fd://Foundation/KVC/KVC?c=Key-Value Coding
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_KVC_KVC;

/// fd://Foundation/KVO?c=Key-Value Observing
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_KVO;

/// fd://Foundation/Lock/DeadLock?c=造成线程死锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_DeadLock;

/// fd://Foundation/Lock/Mutex?c=c语言实现的互斥锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_Mutex;

/// fd://Foundation/Lock/MutexTry?c=c语言实现的互斥锁&try=1
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_MutexTry;

/// fd://Foundation/Lock/NSCondition?c=线程检查器和锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_NSCondition;

/// fd://Foundation/Lock/NSConditionLock?c=条件锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_NSConditionLock;

/// fd://Foundation/Lock/NSLock?c=简单的互斥锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_NSLock;

/// fd://Foundation/Lock/NSRecursiveLock?c=递归锁
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_NSRecursiveLock;

/// fd://Foundation/Lock/OSSpinLock?c=自旋锁（不再安全）
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_OSSpinLock;

/// fd://Foundation/Lock/Semaphore?c=信号量
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Lock_Semaphore;

/// fd://Foundation/Thread/GCD/Group?c=分组队列
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_GCD_Group;

/// fd://Foundation/Thread/GCD/barrier?c=栅栏
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_GCD_barrier;

/// fd://Foundation/Thread/GCD/concurrent?c=并行队列
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_GCD_concurrent;

/// fd://Foundation/Thread/GCD/main?c=主队列
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_GCD_main;

/// fd://Foundation/Thread/GCD/serial?c=串行队列
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_GCD_serial;

/// fd://Foundation/Thread/NSOpertaion?c=线程操作
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_NSOpertaion;

/// fd://Foundation/Thread/NSThread
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_NSThread;

/// fd://Foundation/Thread/RunLoop?c=考试要考
FOUNDATION_EXPORT PGRouterURLKey const fd_Foundation_Thread_RunLoop;


#pragma - mark Extension

/// fd://Extension/DesignPattern/Factory/Method?c=工厂方法模式
FOUNDATION_EXPORT PGRouterURLKey const fd_Extension_DesignPattern_Factory_Method;

/// fd://Extension/DesignPattern/Factory/Simpify?c=简单工厂模式
FOUNDATION_EXPORT PGRouterURLKey const fd_Extension_DesignPattern_Factory_Simpify;


#pragma - mark Foundation

/// ft://Foundation/Lock/OSUnfairLock?c=自旋锁，iOS 10替代方案
FOUNDATION_EXPORT PGRouterURLKey const ft_Foundation_Lock_OSUnfairLock;


#pragma - mark Arithmetic

/// fd://Arithmetic/NSDate
FOUNDATION_EXPORT PGRouterURLKey const fd_Arithmetic_NSDate;


#pragma - mark UIView

/// gd://UIView/Equalization
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_Equalization;

/// gd://UIView/Lifecycle?c=生命周期
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_Lifecycle;

/// gd://UIView/UILabelInset
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_UILabelInset;

/// gd://UIView/WebView/UIWebView
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_WebView_UIWebView;

/// gd://UIView/WebView/WKWebView?wkwebview=1
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_WebView_WKWebView;

/// gd://UIView/entrance?c=总入口
FOUNDATION_EXPORT PGRouterURLKey const gd_UIView_entrance;


#pragma - mark AutoLayout

/// gd://AutoLayout/UIScrollView
FOUNDATION_EXPORT PGRouterURLKey const gd_AutoLayout_UIScrollView;


#pragma - mark InterfaceBuild

/// gd://InterfaceBuild/Storyboard
FOUNDATION_EXPORT PGRouterURLKey const gd_InterfaceBuild_Storyboard;


#pragma - mark General

/// UIKit://General/Animation/Custom?c=自定义动画&type=1
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_Animation_Custom;

/// UIKit://General/Animation/KeyFrame?c=关键帧动画&type=2
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_Animation_KeyFrame;

/// UIKit://General/Animation/Normal?c=一般动画
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_Animation_Normal;

/// UIKit://General/DarkMode?c=黑暗模式
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_DarkMode;

/// UIKit://General/FontFamilys?c=所有字体
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_FontFamilys;

/// UIKit://General/SignInWithApple?c=使用苹果登录
FOUNDATION_EXPORT PGRouterURLKey const uikit_General_SignInWithApple;


#pragma - mark UIViewController

/// gd://UIViewController/PushStack
FOUNDATION_EXPORT PGRouterURLKey const gd_UIViewController_PushStack;


#pragma - mark UIControl

/// gd://UIControl/UIButton
FOUNDATION_EXPORT PGRouterURLKey const gd_UIControl_UIButton;

/// gd://UIControl/UITextField
FOUNDATION_EXPORT PGRouterURLKey const gd_UIControl_UITextField;

