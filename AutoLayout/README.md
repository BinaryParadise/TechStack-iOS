## AutoLayout自动布局

### 推荐三方库

**[Masonary](https://github.com/SnapKit/Masonry)**

### 约束优先级

在Autolayout中每个约束都有一个优先级, 优先级的范围是1 ~ 1000。创建一个约束，默认的优先级是最高的1000

##### Content Hugging Priority

表示一个控件抗拉伸的优先级。优先级越高，越不容易被拉伸，默认是250。

###### Content Compression Resistance Priority

表示一个控件抗压缩的优先级。优先级越高，越不容易被压缩，默认是750
