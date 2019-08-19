# 源码编译

源码地址: https://github.com/apple/swift/tree/stable

## 获取源码

```ruby
mkdir swift_source
cd swift_source
git clone git@github.com:apple/swift.git
./swift/utils/update-checkout --clone-with-ssh
```

## 使用Xcode编译

```ruby
./swift/utils/build-script --xcode
```
