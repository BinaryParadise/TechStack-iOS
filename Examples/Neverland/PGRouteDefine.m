//
//  PGRouteDefine.m
//  Peregrine
//
//  Created by Rake Yang on 2020/3/19.
//  Copyright © 2020 BinaryParadise. All rights reserved.

#import "PGRouteDefine.h"
    
#pragma - mark Foundation


PGRouterURLKey const fd_Foundation_ARC = @"fd://Foundation/ARC?c=自动内存管理";

PGRouterURLKey const fd_Foundation_Category_Method = @"fd://Foundation/Category/Method?c=分类方法将被编译源文件列表中最后编译的覆盖";

PGRouterURLKey const fd_Foundation_Category_initialize = @"fd://Foundation/Category/initialize?c=objc_msgSend时调用";

PGRouterURLKey const fd_Foundation_Category_load = @"fd://Foundation/Category/load?c=先编译先调用、父类早于子类调用、类和分类加载时调用";

PGRouterURLKey const fd_Foundation_Collection_NSArray_UI = @"fd://Foundation/Collection/NSArray/UI?c=页面展示";

PGRouterURLKey const fd_Foundation_Collection_NSArray_safe = @"fd://Foundation/Collection/NSArray/safe?safe=1&c=安全使用";

PGRouterURLKey const fd_Foundation_Collection_NSArray_unsafe = @"fd://Foundation/Collection/NSArray/unsafe?c=正常使用（不安全🔞）";

PGRouterURLKey const fd_Foundation_DataType_Const = @"fd://Foundation/DataType/Const";

PGRouterURLKey const fd_Foundation_DataType_Float = @"fd://Foundation/DataType/Float";

PGRouterURLKey const fd_Foundation_GCD_Barrier_async = @"fd://Foundation/GCD/Barrier/async?c=【并行队列】不等待插入任务完成继续加入任务";

PGRouterURLKey const fd_Foundation_GCD_Barrier_sync = @"fd://Foundation/GCD/Barrier/sync?c=【并行队列】等待插入任务执行完成后继续加入任务";

PGRouterURLKey const fd_Foundation_GCD_Concurrent_async = @"fd://Foundation/GCD/Concurrent/async?c=异步:新线程执行，执行顺序不确定";

PGRouterURLKey const fd_Foundation_GCD_Concurrent_sync = @"fd://Foundation/GCD/Concurrent/sync?c=同步:主线程执行，按加入的先后顺序执行";

PGRouterURLKey const fd_Foundation_GCD_GlobalConcurrent_async = @"fd://Foundation/GCD/GlobalConcurrent/async?c=异步:新线程执行，顺序不确定（合适执行由优先级确定）";

PGRouterURLKey const fd_Foundation_GCD_GlobalConcurrent_sync = @"fd://Foundation/GCD/GlobalConcurrent/sync?c=同步:主线程执行，按顺序执行";

PGRouterURLKey const fd_Foundation_GCD_Group_concurrent = @"fd://Foundation/GCD/Group/concurrent?c=异步:并行队列新线程，顺序不确定，完成后通知";

PGRouterURLKey const fd_Foundation_GCD_Group_serial = @"fd://Foundation/GCD/Group/serial?c=异步:串行队列新线程，按顺序执行，完成后通知";

PGRouterURLKey const fd_Foundation_GCD_Main_async = @"fd://Foundation/GCD/Main/async?c=异步:按顺序执行，耗时任务会造成阻塞";

PGRouterURLKey const fd_Foundation_GCD_Main_syncMain = @"fd://Foundation/GCD/Main/syncMain?c=🔞同步:互相等待造成死锁，抛出异常EXC_BAD_INSTRUCTION";

PGRouterURLKey const fd_Foundation_GCD_Semaphore_create = @"fd://Foundation/GCD/Semaphore/create?c=使用信号量&use=1";

PGRouterURLKey const fd_Foundation_GCD_Semaphore_normal = @"fd://Foundation/GCD/Semaphore/normal?c=🔞不使用，会导致异常&use=0";

PGRouterURLKey const fd_Foundation_GCD_Serial_async = @"fd://Foundation/GCD/Serial/async?c=异步:开启新线程，按顺序执行";

PGRouterURLKey const fd_Foundation_GCD_Serial_sync = @"fd://Foundation/GCD/Serial/sync?c=同步:主线程执行，按顺序执行";

PGRouterURLKey const fd_Foundation_KVC_KVC = @"fd://Foundation/KVC/KVC?c=Key-Value Coding";

PGRouterURLKey const fd_Foundation_KVO = @"fd://Foundation/KVO?c=Key-Value Observing";

PGRouterURLKey const fd_Foundation_Lock_DeadLock = @"fd://Foundation/Lock/DeadLock?c=造成线程死锁";

PGRouterURLKey const fd_Foundation_Lock_Mutex = @"fd://Foundation/Lock/Mutex?c=c语言实现的互斥锁";

PGRouterURLKey const fd_Foundation_Lock_MutexTry = @"fd://Foundation/Lock/MutexTry?c=c语言实现的互斥锁&try=1";

PGRouterURLKey const fd_Foundation_Lock_NSCondition = @"fd://Foundation/Lock/NSCondition?c=线程检查器和锁";

PGRouterURLKey const fd_Foundation_Lock_NSConditionLock = @"fd://Foundation/Lock/NSConditionLock?c=条件锁";

PGRouterURLKey const fd_Foundation_Lock_NSLock = @"fd://Foundation/Lock/NSLock?c=简单的互斥锁";

PGRouterURLKey const fd_Foundation_Lock_NSRecursiveLock = @"fd://Foundation/Lock/NSRecursiveLock?c=递归锁";

PGRouterURLKey const fd_Foundation_Lock_OSSpinLock = @"fd://Foundation/Lock/OSSpinLock?c=自旋锁（不再安全）";

PGRouterURLKey const fd_Foundation_Lock_Semaphore = @"fd://Foundation/Lock/Semaphore?c=信号量";

PGRouterURLKey const fd_Foundation_Thread_GCD_Group = @"fd://Foundation/Thread/GCD/Group?c=分组队列";

PGRouterURLKey const fd_Foundation_Thread_GCD_barrier = @"fd://Foundation/Thread/GCD/barrier?c=栅栏";

PGRouterURLKey const fd_Foundation_Thread_GCD_concurrent = @"fd://Foundation/Thread/GCD/concurrent?c=并行队列";

PGRouterURLKey const fd_Foundation_Thread_GCD_main = @"fd://Foundation/Thread/GCD/main?c=主队列";

PGRouterURLKey const fd_Foundation_Thread_GCD_serial = @"fd://Foundation/Thread/GCD/serial?c=串行队列";

PGRouterURLKey const fd_Foundation_Thread_NSOpertaion = @"fd://Foundation/Thread/NSOpertaion?c=线程操作";

PGRouterURLKey const fd_Foundation_Thread_NSThread = @"fd://Foundation/Thread/NSThread";

PGRouterURLKey const fd_Foundation_Thread_RunLoop = @"fd://Foundation/Thread/RunLoop?c=考试要考";

#pragma - mark Extension


PGRouterURLKey const fd_Extension_DesignPattern_Factory_Method = @"fd://Extension/DesignPattern/Factory/Method?c=工厂方法模式";

PGRouterURLKey const fd_Extension_DesignPattern_Factory_Simpify = @"fd://Extension/DesignPattern/Factory/Simpify?c=简单工厂模式";

#pragma - mark Foundation


PGRouterURLKey const ft_Foundation_Lock_OSUnfairLock = @"ft://Foundation/Lock/OSUnfairLock?c=自旋锁，iOS 10替代方案";

#pragma - mark UIView


PGRouterURLKey const gd_UIView_Equalization = @"gd://UIView/Equalization";

PGRouterURLKey const gd_UIView_Lifecycle = @"gd://UIView/Lifecycle?c=生命周期";

PGRouterURLKey const gd_UIView_UILabelInset = @"gd://UIView/UILabelInset";

PGRouterURLKey const gd_UIView_WebView_UIWebView = @"gd://UIView/WebView/UIWebView";

PGRouterURLKey const gd_UIView_WebView_WKWebView = @"gd://UIView/WebView/WKWebView?wkwebview=1";

PGRouterURLKey const gd_UIView_entrance = @"gd://UIView/entrance?c=总入口";

#pragma - mark AutoLayout


PGRouterURLKey const gd_AutoLayout_UIScrollView = @"gd://AutoLayout/UIScrollView";

#pragma - mark InterfaceBuild


PGRouterURLKey const gd_InterfaceBuild_Storyboard = @"gd://InterfaceBuild/Storyboard";

#pragma - mark General


PGRouterURLKey const uikit_General_Animation_Custom = @"UIKit://General/Animation/Custom?c=自定义动画&type=1";

PGRouterURLKey const uikit_General_Animation_KeyFrame = @"UIKit://General/Animation/KeyFrame?c=关键帧动画&type=2";

PGRouterURLKey const uikit_General_Animation_Normal = @"UIKit://General/Animation/Normal?c=一般动画";

PGRouterURLKey const uikit_General_DarkMode = @"UIKit://General/DarkMode?c=黑暗模式";

PGRouterURLKey const uikit_General_FontFamilys = @"UIKit://General/FontFamilys?c=所有字体";

PGRouterURLKey const uikit_General_SignInWithApple = @"UIKit://General/SignInWithApple?c=使用苹果登录";

#pragma - mark UIViewController


PGRouterURLKey const gd_UIViewController_PushStack = @"gd://UIViewController/PushStack";

#pragma - mark UIControl


PGRouterURLKey const gd_UIControl_UIButton = @"gd://UIControl/UIButton";

PGRouterURLKey const gd_UIControl_UITextField = @"gd://UIControl/UITextField";
