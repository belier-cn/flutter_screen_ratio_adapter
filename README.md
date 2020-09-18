# screen_ratio_adapter

A new Flutter package for screen atio adapter，Low invasion cost.Based wide adaptation,height Scroll or leave blank.It's not a utility class.

一个Flutter package ,屏幕适配器，入侵成本极低。基于宽度方向适应，高度滚动或留空。并不是一个screen_util。再也不为适配屏幕重复搬砖。

设计稿如同模特上挂着的衣服，但是强行穿在不同设备上，就成了买家秀，要么左右不对称，甚至撑破。

<img src="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=420958367,1948311389&fm=26&gp=0.jpg" style="zoom:75%;" />

[TOC]

### 基于一种理念

一套多售，这是批量订制而不是私人定制。

服装设计稿——>加工厂批量生产不同尺码——>顾客选购——>着身；

中间环节由本插件代码处理

### 原理

还记得Android原生上[今日头条适配方案](https://juejin.im/post/5b7a29736fb9a019d53e7ee2)吗？就是修改运行时获取的设备屏幕密度比率常数。这个方案很早之前就有人提出过只是人微言轻传播的不好。

对于用户来说屏幕就是一个矩形（至少目前的主流设备）；而主流移动设备已经培养多年用户上下滑动屏幕的习惯；

主流设备变得更“窄”；

基于以上三点，以屏幕宽度适配通用性高，实现效果好。至于实际设备高/宽与设计比例的差异处理，自行留白或纵向改为scrollWidget

### 实践报告

**下图警戒区为故意超出一个单位的示例图**

| \设备                     | android                                                      | Android                                                      | iOS                                                          |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 设备分辨率                | 1080x1794                                                    | 720x2160                                                     | 1242x2688                                                    |
| h/w                       | 1.666                                                        | 3.0                                                          | 2.164                                                        |
| 屏幕密度比率ρ             | 2.625                                                        | 1.2                                                          | 3.0                                                          |
|                           |                                                              |                                                              |                                                              |
| UI稿1（300x510) h/w =1.7  | 过长                                                         | 过短                                                         | 过短                                                         |
| 适配比率ρ(300x510)        | 3.60                                                         | 2.40                                                         | 4.14                                                         |
|                           | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df72aa6ec4cf?w=1080&amp;h=1920&amp;f=png&amp;s=142475" style="zoom:25%;" /> | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df4008003319?w=720&amp;h=2160&amp;f=png&amp;s=88085" style="zoom:25%;" /> | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df3831bbbaa9?w=822&amp;h=1686&amp;f=png&amp;s=214200" style="zoom:25%;" /> |
| UI稿1（414x896) h/w =2.16 | 过长                                                         | 过短                                                         | 不变                                                         |
| 适配比率ρ(414x896)        | 2.608                                                        | 1.739                                                        | 3.0                                                          |
|                           | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df4e1efb90dc?w=1080&amp;h=1920&amp;f=png&amp;s=148927" style="zoom:25%;" /> | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df5c3119b784?w=720&amp;h=2160&amp;f=png&amp;s=90158" style="zoom:25%;" /> | <img src="https://user-gold-cdn.xitu.io/2020/4/18/1718df170d282fee?w=854&amp;h=1738&amp;f=png&amp;s=298566" style="zoom:25%;" /> |
|                           |                                                              |                                                              |                                                              |



[已上传**pub.dev** ️❤️❤️点赞😘😘](https://pub.dev/packages/screen_ratio_adapter)

[已上传**github**    ️❤️❤️加星😘😘](https://github.com/qcks/flutter_screen_ratio_adapter)

### 使用方式

```yaml
点赞加星小礼物
复制粘贴人人爱
如有BUG记小本
携尔长刀来相砍
```


```yaml
dependencies:
  screen_ratio_adapter: ^latest version
```

```dart
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';
///设计稿尺寸，单位应是pt或dp
Size uiSize = Size(414, 896);

//void main() => runApp(MyApp());
void main() {
  return runFxApp(MyApp(), uiSize: uiSize, onEnsureInitialized: () {
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      builder: FxTransitionBuilder(builder: null),
    );
  }
}

```

### 参考及鸣谢

[一种粗暴快速的Android全屏幕适配方案](https://www.jianshu.com/p/b6b9bd1fba4d)

[flutter 屏幕适配](https://github.com/genius158/FlutterTest/blob/master/lib/main.dart)

[flutter屏幕适配 ，一种一劳永逸的全局适配方式](https://juejin.im/post/5cb49e306fb9a068a3729b41#heading-0)



