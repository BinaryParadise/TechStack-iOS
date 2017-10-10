# Category
- 定义的协议、方法、属性会在加载二进制代码的时候附加到目标类中

- 如果存在同名方法会覆盖主类方法，方法列表中会存在两个同名方法，Category的方法会在前面默认调用
- 如果多个Category存在相同的方法名，最后一个编译的Category中的方法会在最前面

# +load
- 附加Category到类的工作会先于+load方法的执行
- +load的执行顺序是先类，后category，而category的+load执行顺序是根据编译顺序决定的。

# 关联对象/属性
AssociationsManager里面是由一个静态AssociationsHashMap来存储所有的关联对象的。这相当于把所有对象的关联对象都存在一个全局map里面。而map的的key是这个对象的指针地址（任意两个不同对象的指针地址一定是不同的），而这个map的value又是另外一个AssociationsHashMap，里面保存了关联对象的kv对。
而在对象的销毁逻辑里面