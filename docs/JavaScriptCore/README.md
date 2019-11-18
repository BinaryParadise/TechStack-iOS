# JavaScriptCore是什么?

JavaScriptCore本身仅实现[ECMAScript](http://ecma-international.org/)规范，方便网页交互。不包含来自WebKit框架的XMLHTTPRequest，WebSocket，DOM等之类的东西。

**主要类**:

名称 | 说明
---- | ----
JSContext | 脚本执行上下文
JSValue | 对象转换
JSManagedValue | 内存管理辅助对象
JSVirtualMachine | 虚拟机，有独立的空间和垃圾回收机制
JSExport | 导出协议


## JSVirtualMachine

## JSContext

## JSValue

### 映射关系

|Objective-C type  |   JavaScript type|
|----------------- | ---------------------|
|      nil         |     undefined    |
|     NSNull       |        null    |
|    NSString      |       string   |
|    NSNumber      |   number, boolean    |
|  NSDictionary    |   Object object    |
|    NSArray       |    Array object    |
|     NSDate       |     Date object    |
|    NSBlock       |   Function object    |
|       id         |   Wrapper object   |
|     Class        | Constructor object   |
