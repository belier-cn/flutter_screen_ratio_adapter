import 'package:flutter/material.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

///设计稿尺寸，单位应是pt或dp
//Size uiSize = Size(300, 510);
//Size uiSize = Size(721, 628);
Size uiSize = Size(414, 896) * 1;

//void main() => runApp(MyApp());
void main() {
  return runFxApp(MyApp(), uiSize: uiSize, onEnsureInitialized: (info) {
    /// info.deltaHeight 尺码差值dp
  });
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
      body: Center(
        child: Column(
          children: <Widget>[
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
                  width: 500,
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
              height: info.deltaHeight.abs(),
              width: double.infinity,
              color: Colors.deepPurpleAccent,
              child: Text("deltaHeight=${info.deltaHeight}"),
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
                  return NextPage();
                }));
              },
              child: Text("NextPage"),
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
