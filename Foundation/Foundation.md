# NSString

char和string类型在ObjC中同样可用，但是基本也可以不用。NSString作为整个Cocoa框架的灵魂类，强大无比，基本能胜任现代编程语言对于字符串的所有基本处理和更复杂的处理。详细使用方法将在后面专门章节介绍。

# NSValue

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

# NSMutableArray < NSArray

# NSMutableDictionary < NSDictionary
