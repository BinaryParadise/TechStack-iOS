# @property

- 自动生成setter、getter声明和实现
- 以名称*`_属性名`*定义成员变量

#@synthesize
- 让编译器自动生成setter/getter方法，当有自定义的方法时，屏蔽自动生成失效
- `Category`中无法使用

#@dynamic
- `Category`中告诉编译器不自动生成setter/getter方法，避免编译器件产生警告
- `Category`中添加属性不会生成`ivar`成员变量，属于运行时赋值