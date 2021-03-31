# BeSwifter

Objective-C和Swift混编

## 使用OC编写Pod库

### 使用其它OC的Pod库

```ruby
# 添加依赖
s.dependency 'WechatOpenSDK'
```

### 使用其它Swift的Pod库

```ruby
# 添加依赖
s.dependency 'SwiftPodLib'
```

```objc
@import SwiftPodLib;

+ (BOOL)verification {    
    return [SwiftPodLib verification] && [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}
```

### 使用其它混编Pod库

> 只使用OC部分

```objc
// 导入使用
#import <WechatOpenSDK/WXApi.h>

+ (BOOL)verification {    
    return [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}
```

## 使用Swift编写Pod库

### 使用其它OC的Pod库

```objc
// 添加头文件依赖（仅限依赖其它OC库）
#import <YYCategories/YYCategories.h>
```

```swift
// 直接使用OC代码
public static func verification() -> Bool {
    return SwiftPodLib.verification() && NSDate(string: "2021-03-31", format: "yyyy-MM-dd")?.year == 2021
}
```

### 使用其它Swift的Pod库

```swift
// 导入后直接使用
import SwiftPodLib
```

### 使用其它混编的Pod库

> 待实践

## 使用OC和Swift编写Pod库

> OC调用Swift
- 设置为public
- 添加@objc

> Swift调用OC
- 直接使用

### 使用其它OC的Pod库

```objc
// 添加头文件依赖（仅限依赖其它OC库）
#import <YYCategories/YYCategories.h>
```

```swift
// 直接使用OC代码
public static func verification() -> Bool {
    return SwiftPodLib.verification() && NSDate(string: "2021-03-31", format: "yyyy-MM-dd")?.year == 2021
}
```

### 使用其它Swift的Pod库

```swift
// 导入后直接使用
import SwiftPodLib
```

### 使用其它混编Pod库

> CocoaLumberjack暂未找到解决办法