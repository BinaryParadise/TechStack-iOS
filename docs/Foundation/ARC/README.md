# 内存管理
## readwrite、readonly

修饰可读访问，默认为readwrite

## assign、retain、strong、copy

修饰访问申明，主要用于内存管理

retain主要是MRC中使用，和strong等价

修饰block不同

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
|-ObjCPropertyDecl number1 'long' assign readwrite atomic unsafe_unretained > @property long number1;
|-ObjCPropertyDecl name1 'NSString *' readwrite atomic strong > @property NSString *name1;
```



[Block属性参见详解](../Blocks/README.md)