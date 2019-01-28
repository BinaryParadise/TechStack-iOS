# 数字

## bool 与 BOOL

C语言标准中没有布尔型变量，C++中的bool类型，为true和false，这在许多其他的类C语言中都是一样的，例如java、C#、php等，但在ObjC中，你可以使用bool类型，但更建议使用ObjC专用的`BOOL`类型，这个基本布尔型的值为YES和NO。

## int 与 NSInteger

C语言中的int，在ObjC中同样支持，但不建议你用int，而推荐使用Cocoa框架中的NSInteger

```objc
#if __LP64__ || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif
```

## float 与 CGFloat

CGFloat是在UIKit中定义的，CG代表CoreGraphic

```objc
#if defined(__LP64__) && __LP64__
# define CGFLOAT_TYPE double
# define CGFLOAT_IS_DOUBLE 1
# define CGFLOAT_MIN DBL_MIN
# define CGFLOAT_MAX DBL_MAX
#else
# define CGFLOAT_TYPE float
# define CGFLOAT_IS_DOUBLE 0
# define CGFLOAT_MIN FLT_MIN
# define CGFLOAT_MAX FLT_MAX
#endif

/* Definition of the `CGFloat' type and `CGFLOAT_DEFINED'. */

typedef CGFLOAT_TYPE CGFloat;
```
