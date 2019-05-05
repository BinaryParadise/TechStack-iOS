## 自定义clang的Attribute (`__attribtue__`)

[官方文档](https://clang.llvm.org/docs/InternalsManual.html#how-to-add-an-attribute)

### 属性的结构

属性定义在clang源码目录：`include/clang/Basic/Attr.td`

示例

```ruby
def Aligned : InheritableAttr {
  let Spellings = [GCC<"aligned">, Declspec<"align">, Keyword<"alignas">,
                   Keyword<"_Alignas">];
  let Args = [AlignedArgument<"Alignment", 1>];
  let Accessors = [Accessor<"isGNU", [GCC<"aligned">]>,
                   Accessor<"isC11", [Keyword<"_Alignas">]>,
                   Accessor<"isAlignas", [Keyword<"alignas">,
                                          Keyword<"_Alignas">]>,
                   Accessor<"isDeclspec",[Declspec<"align">]>];
  let Documentation = [Undocumented];
}
```

### 属性的添加步骤

  1. 在include/clang/Basic/Attr.td中添加属性的定义
  2. 在include/clang/Basic/AttrDocs.td中添加文档定义
  3. 在lib/Sema/SemaDeclAttr.cpp中添加语义操作

### clang常用命令

展示抽象语法树
```ruby
clang -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -fmodules -fsyntax-only -Xclang -ast-dump TestClass.m
```

结果示例
```ruby
|-ImportDecl 0x7f8b801f6000 <./TestClass.h:9:1> col:1 implicit Foundation
|-ObjCInterfaceDecl 0x7f8b801f6d30 <line:16:1, line:18:2> line:16:12 TestClass
| |-super ObjCInterface 0x7f8b801f61e8 'NSObject'
| |-ObjCImplementation 0x7f8b801f6ed0 'TestClass'
| `-ObjCRuntimeNameAttr 0x7f8b801f6e00 <line:15:16, col:68> "86d3cd67eed8590114cbfc3c8ab1d374"
|-ObjCImplementationDecl 0x7f8b801f6ed0 <TestClass.m:11:1, line:14:1> line:11:17 TestClass
| `-ObjCInterface 0x7f8b801f6d30 'TestClass'
`-<undeserialized declarations>
1 warning generated.
```
