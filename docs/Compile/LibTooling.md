[参考系列文章](https://www.cnblogs.com/dechaos/p/7416585.html)

## 创建项目

因为需要基于LibTooling进行开发，选择了在Clang项目内添加一个Tools的方式来简化流程。

### 创建工具目录

```ruby
cd llvm/tools/clang/tools && mkdir clang-peregrine && cd clang-peregrine
```
### 输出参数

```ruby
${HOME}/Github/Peregrine/Example/Peregrine/PeregrineActionTest.m
--
-isysroot
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
-isystem
-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/10.0.0/include
-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1
-I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include
-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks
```
