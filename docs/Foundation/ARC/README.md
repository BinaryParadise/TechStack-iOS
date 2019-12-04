# 内存管理
## readwrite、readonly

修饰可读访问，默认为readwrite

## assign、retain、strong、copy

修饰访问申明，主要用于内存管理

retain主要是MRC中使用，和strong等价，修饰`block`有些许不同

## weak

> weak是弱引用，用weak描述修饰或者所引用对象的计数器不会加一，并且会在引用的对象被释放的时候自动被设置为nil，大大避免了野指针访问坏内存引起崩溃的情况，另外weak还可以用于解决循环引用。

weak_table_t是一个全局weak 引用的表，使用不定类型对象的地址作为 key，用 weak_entry_t 类型结构体对象作为 value 。其中的 weak_entries 成员

```c
struct weak_table_t {
    weak_entry_t *weak_entries; //保存了所有指向指定对象的weak指针   weak_entries的对象
    size_t    num_entries;              // weak对象的存储空间
    uintptr_t mask;                      //参与判断引用计数辅助量
    uintptr_t max_hash_displacement;    //hash key 最大偏移值
};

typedef objc_object ** weak_referrer_t;
struct weak_entry_t {
    DisguisedPtrobjc_object> referent;
    union {
        struct {
            weak_referrer_t *referrers;
            uintptr_t        out_of_line : 1;
            uintptr_t        num_refs : PTR_MINUS_1;
            uintptr_t        mask;
            uintptr_t        max_hash_displacement;
        };
        struct {
            // out_of_line=0 is LSB of one of these (don't care which)
            weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
        };
    }
}
```



1. 初始化时runtime调用objc_initWeak函数，将会初始化一个新的weak指针指向对象的地址

   ```bash
   clang -rewrite-objc -stdlib=libc++ -fobjc-runtime=macosx-10.7 Example/Peregrine/FPModel.m -fobjc-arc
   ```

   

2. 添加引用时：objc_initWeak函数会调用 objc_storeWeak() 函数， objc_storeWeak() 的作用是更新指针指向，创建对应的弱引用表。

3. 释放时，调用clearDeallocating函数。clearDeallocating函数首先根据对象地址获取所有weak指针地址的数组，然后遍历这个数组把其中的数据设为nil，最后把这个entry从weak表中删除，最后清理对象的记录。

## atomic、nonatomic

修饰属性原子性，atomic相对于nonatomic线程更加安全但不保证，而且效率低些

其实就是增加了线程锁@synchronized

## unsafe_unretained

和assign等价，对象释放后指针不会置空造成野指针而__weak不会

## 属性的默认申明和内存管理模式有关

> MRC模式下 @property 默认是atomic、readwrite、assign

```objc
@property long number1;
@property NSString *name1;
|-ObjCPropertyDecl number1 'long' assign readwrite atomic unsafe_unretained
|-ObjCPropertyDecl name1 'NSString *' assign readwrite atomic unsafe_unretained
```

> ARC模式下 @property 默认是atomic、readwrite、assign（对象类型是strong，包括block）

```objc
@property long number1;
@property NSString *name1;
|-ObjCPropertyDecl number1 'long' assign readwrite atomic unsafe_unretained
|-ObjCPropertyDecl name1 'NSString *' readwrite atomic strong
```



[Block属性参见详解](../Blocks/README.md)