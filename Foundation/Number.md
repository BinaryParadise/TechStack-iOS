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

## NSValue

NSValue是个可以和各种基本数据类型互转的类。包括CGPoint、CGRect、CGSize等等。例如

```ObjC
[NSValue valueWithCGSize:CGSizeMake(100, 100)];
[NSValue valueWithRange:NSMakeRange(0, 10)];

```

# NSNumber

NSNumber与上面不同的是，NSNumber不是基本数据类型，而是对象。
NSNumber 继承自 NSValue，而NSValue继承自NSObject。
NSNumber支持和基本数据类型的互转。

另外NSNumber支持和NSString一样的@符号简写

```objc
NSNumber * number = @(123);
NSNumber * number1 = @(3.1415);
NSNumber * number2 = @(YES);

NSInteger intValue = [number integerValue];
CGFloat floatValue = [number1 doubleValue];
BOOL boolValue = [number2 boolValue];
```

## 精确计算浮点数

```ObjC
// 精确小数点计算
    NSString *num1 = @"1.99999999999";
    NSString *num2 = @"0.00000000001";
    NSString *num3 = @"0.00000001234";
    NSString *num4 = @"1.23456789876";

    // 创建NSDecimalNumber对象
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:num1];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num2];
    NSDecimalNumber *number3 = [NSDecimalNumber decimalNumberWithString:num3];
    NSDecimalNumber *number4 = [NSDecimalNumber decimalNumberWithString:num4];

    // 加
    NSDecimalNumber *sumNum = [number2 decimalNumberByAdding:number3];
    NSLog(@"%@ + %@ = %@", number2.stringValue, number3.stringValue, sumNum.stringValue);

    // 减
    NSDecimalNumber *subNum = [number1 decimalNumberBySubtracting:number2];
    NSLog(@"%@ - %@ = %@", number1.stringValue, number2.stringValue, subNum.stringValue);

    // 乘
    NSDecimalNumber *multiNum = [number4 decimalNumberByMultiplyingBy:number2];
    NSLog(@"%@ * %@ = %@", number4.stringValue, number2.stringValue, multiNum.stringValue);

    // 除
    NSDecimalNumber *dividNum = [number4 decimalNumberByDividingBy:number2];
    NSLog(@"%@ / %@ = %@", number4.stringValue, number2.stringValue, dividNum.stringValue);

    //1.99999999999 - 0.00000000001 = 1.99999999998

    //0.00000000001 + 0.00000001234 = 0.00000001235

    //1.23456789876 * 0.00000000001 = 0.0000000000123456789876

    //1.23456789876 / 0.00000000001 = 123456789876
```
