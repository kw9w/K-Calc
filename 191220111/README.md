难点及解决方案：

横屏如何解决，一开始想尝试多个View Controller，但老师上课时提到计算机是典型的单个View的app，后面的开发才会使用到多个View。

Auto layout确实很方便，老师也提到了很多，绘制竖屏的UI很方便，但是怎么在横屏显示不一样的内容一开始确实比较confusing，好在翻了官方文档后并结合老师课件后，得到如下解决方案



按照老师的实例写计算功能。

遇到问题：启动计算器后，如果直接点Rand，pi等单目操作符会遇到问题报错

```swift
Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

后与系统计算器对比，发现开始时屏幕上初始值为0，示例中设置为空，故一开始digitondisplay为nil报错，修改viewDidLoad后得到解决

```swift
- self.display.text! = ""
+ self.display.text! = "0"
```



总结：尽力而行，虽然不能像标准计算器那样尽善尽美，按照老师在群里提及的要求，支持单步计算就行，多步计算存在的一些bug，比如3+1=后不断按=，有一些思路，但没有找到太好的解决方案。不过感觉重点还是老师示例中的enum等巧妙的操作。