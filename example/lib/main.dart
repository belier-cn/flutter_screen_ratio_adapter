import 'package:flutter/material.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

///设计稿尺寸，单位应是pt或dp
//var uiSize = BlueprintsRectangle(300, 510);
//var uiSize = BlueprintsRectangle(721, 628);
var uiSize = BlueprintsRectangle(414, 878);

//void main() => runApp(MyApp());
void main() {
  return runFxApp(MyApp(),
      uiBlueprints: uiSize, onEnsureInitialized: (info) {}, enableLog: true);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '设计尺寸${uiSize.toString()}'),
      builder: FxTransitionBuilder(builder: null),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NextPage();
              }));
            },
            child: Center(child: Text("NextPage")),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '设计尺寸 414x896 ${info.deltaLength}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '设计尺寸 414x896 fontSize: 19',
                style: TextStyle(fontSize: 19),
              ),
              Text(
                '设计尺寸 414x896 fontSize: 18',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Container(
                      color: Colors.orange,
                      child: Text("w= 100,    h=100"),
                    ),
                  ),
                  SizedBox(
                    width: 314,
                    height: 100,
                    child: Container(
                      color: Colors.green,
                      child: Text("w=314"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text("W= 414"),
                    width: 414,
                    height: 80,
                    color: Colors.greenAccent,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text("W= 415"),
                    width: 415,
                    height: 80,
                    color: Colors.lightBlue,
                  ),
                ],
              ),
              Text(
                '设计尺寸 300x510',
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text("W= 100"),
                    width: 100,
                    height: 30,
                    color: Colors.lightBlue,
                  ),
                  Container(
                    child: Text("W= 200"),
                    width: 200,
                    height: 30,
                    color: Colors.red,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text("W= 100"),
                    width: 100,
                    height: 30,
                    color: Colors.yellow,
                  ),
                  Container(
                    child: Text("W= 100"),
                    width: 100,
                    height: 30,
                    color: Colors.lightBlue,
                  ),
                  Container(
                    child: Text("W= 100"),
                    width: 100,
                    height: 30,
                    color: Colors.yellow,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text("W= 301"),
                    width: 300,
                    height: 30,
                    color: Colors.cyanAccent,
                  ),
                  Container(
                    child: Text(""),
                    width: 1,
                    height: 30,
                    color: Colors.red,
                  ),
                ],
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NextPage extends StatelessWidget {
  NextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("@@NextPageMediaQuery ${MediaQuery.of(context)}");
    return Scaffold(
      appBar: AppBar(
        title: Text("next page"),
      ),
      backgroundColor: Colors.green,
      body: Container(
//        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: info.actualDpSize.height,
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Container(
              height: info.deltaLength.abs(),
              width: double.infinity,
              color: Colors.deepPurpleAccent,
              child: Text("deltaHeight=${info.deltaLength}"),
            ),
            Text("info.actualDpSize.height=${info.actualDpSize}"),
            Text(
              '设计尺寸 414x896',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '设计尺寸 414x896 fontSize: 19',
              style: TextStyle(fontSize: 19),
            ),
            Text(
              '设计尺寸 414x896 fontSize: 18',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '设计尺寸 300x510',
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text("W= 100"),
                  width: 100,
                  height: 30,
                  color: Colors.lightBlue,
                ),
                Container(
                  child: Text("W= 200"),
                  width: 200,
                  height: 30,
                  color: Colors.red,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text("W= 100"),
                  width: 100,
                  height: 30,
                  color: Colors.yellow,
                ),
                Container(
                  child: Text("W= 100"),
                  width: 100,
                  height: 30,
                  color: Colors.lightBlue,
                ),
                Container(
                  child: Text("W= 100"),
                  width: 100,
                  height: 30,
                  color: Colors.yellow,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 100),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text("W= 301"),
                  width: 300,
                  height: 30,
                  color: Colors.cyanAccent,
                ),
                Container(
                  child: Text(""),
                  width: 1,
                  height: 30,
                  color: Colors.red,
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage2();
                }));
              },
              child: Text("NextPage"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage3();
                }));
              },
              child: Text("NextPage3"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage4();
                }));
              },
              child: Text("NextPage4"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NextPage2 extends StatelessWidget {
  NextPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("build哈哈哈");
    return Scaffold(
//      appBar: AppBar(
//        title: Text("哈哈哈"),
//      ),
      body: Column(
        children: [
//          Container(
//              color: Colors.green,
//              width: double.infinity,
//              height: MediaQuery.of(context).padding.top,),
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).padding.top,
              color: Colors.red),
          Container(
              color: Colors.deepPurpleAccent,
              width: double.infinity,
//              height: info.bodyMaxLength-kToolbarHeight,
              height: info.bodyMaxLength,
              child: Text("body${info.bodyMaxLength}")),
        ],
      ),
    );
  }
}

class NextPage3 extends StatelessWidget {
  NextPage3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: info.uiBlueprints.length,
            color: Colors.red,
            child: Text("PinTenonWidget测试"),
          ),
          PinTenonWidget(),
        ],
      ),
    );
  }
}

class NextPage4 extends StatelessWidget {
  NextPage4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("PinTenonWidget测试"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
//            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.vertical),
            height: info.bodyMaxLength - kToolbarHeight,
            color: Colors.red,
            child: Text(
                "PinTenonWidget测试 ${MediaQuery.of(context).padding.vertical}"),
          ),
        ],
      ),
    );
  }
}
