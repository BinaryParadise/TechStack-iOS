
## 编写插件

`文件夹结构标记:`
![](/images/clang_1.jpg)

1. 插件加载逻辑定义
```txt
//在CMakeLists.txt文件最后
add_clang_subdirectory(AnnotationPlugin)
```
2. 插件目录包含源码和配置文件

3. 插件编译配置文件
4. 插件源码
5. 重新编译
  ```ruby
  cmake -G Xcode ../llvm && open LLVM.xcodeproj
  ```
  选择target 插件名称 编译，完成后会生成动态库文件

## 使用插件

#### 在命令行中使用

1. 新建测试文件test.m

```objc
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@end

@implementation ViewController
- (instancetype)init
{
    if(self = [super init]){

    }
    return self;
}
@end

```
  2. 将 test.m 和 AnnotationPlugin.dylib 放在llvm_xcode同级目录目录然后执行
```objc
-isysroot ${SDKROOT} -Xclang -load -Xclang ${CC}/PeregrinePlugin.dylib -Xclang -add-plugin -Xclang PeregrinePlugin
```
  输出文件 test.o 表示编译成功

#### 在 Xcode 10 中使用插件

  1. 设置编译器

    在Build Settings栏目中新增两项用户定义的设置 `CC`、`CXX`

    ![](/images/clang_4.png)

    如果👆的步骤都确认无误之后，在编译的时候如果遇到了下图这种错误
    ![](/images/clang_5.jpg)

    则可以在Build Settings栏目中搜索index，将Enable Index-Wihle-Building Functionality的Default改为NO。

  2. 加载插件

    在Xcode项目中指定加载插件动态库：Build Settings > Other C Flags
    ```ruby
    -Xclang -load -Xclang /Users/bonana/Github/ClangPlugin/llvm_xcode/Debug/lib/AnnotationPlugin.dylib -Xclang -add-plugin -Xclang AnnotationPlugin
    ```
    ![](/images/clang_3.jpg)

    编译项目后，即可看到插件输入的错误提示如下所示：
    ![](/images/clang_4.jpg)


## 最终效果
