# UIView

## 主要方法（调用顺序）

#### - (instancetype)init;

#### - (instancetype)initWithFrame:(CGRect)frame;

- 通过此方法初始化UIView时不会调用`- init`

#### - (void)drawRect:(CGRect)rect;

- 初始化时未指定frame时不会调用。
- 该方法在调用sizeThatFits后被调用，所以可以先调用sizeToFit计算出size。然后系统自动调用drawRect:方法。

#### - (void)setNeedsLayout;

> 标记视图需要重新布局，不会立即刷新，但是一定会调用layoutSubviews。

#### - (void)layoutIfNeeded

> 如果有需要重新布局的标记，则立即调用

#### - (void)layoutSubviews;
> 调用时机
- 通过frame初始化且不为CGRectZero
- 调用setNeedsLayout标记需要重新布局
- frame变化
- 屏幕旋转

#### - (void)dealloc;
