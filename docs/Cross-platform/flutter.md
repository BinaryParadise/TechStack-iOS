## 开发环境搭建

```bash
# 使用镜像
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
# 获取Flutter
git clone git@github.com:flutter/flutter.git ~/flutter
export PATH="$HOME/flutter/bin:$PATH"
# 检查环境安装依赖
flutter doctor
```

## Android Studio

```bash
Plugins中搜索Flutter、Dart并安装
```

## Intellij Idea

```bash
Plugins中搜索Flutter、Dart并安装
```



## 调试

```bash
# 打开iOS模拟器
open -a Simulator
# 打开安卓模拟器
flutter emulators --launch Pixel_2_API_26
# 创建项目
flutter create my_app
# 启动调试
flutter run
```

