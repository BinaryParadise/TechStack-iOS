## NSValue

NSValue是个可以和各种基本数据类型互转的类。包括CGPoint、CGRect、CGSize等等。例如

```ObjC
[NSValue valueWithCGSize:CGSizeMake(100, 100)];
[NSValue valueWithRange:NSMakeRange(0, 10)];

```
