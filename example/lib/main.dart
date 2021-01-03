import 'package:flutter/material.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

///设计稿尺寸，单位应是pt或dp
//var uiSize = BlueprintsRectangle(300, 510);
//var uiSize = BlueprintsRectangle(721, 628);
var uiSize = BlueprintsRectangle(414, 878);

//void main() => runApp(MyApp());
void main() {
  return runFxApp(MyApp(),
      uiBlueprints: uiSize, onEnsureInitialized: () {}, enableLog: true);
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
      // builder: FxTransitionBuilder(builder: null),
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
                '设计尺寸 414x896 ',
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
        height: Info.instance.actualDpSize.height,
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Container(
              height: Info.instance.deltaLength.abs(),
              width: double.infinity,
              color: Colors.deepPurpleAccent,
              child: Text("deltaHeight=${Info.instance.deltaLength}"),
            ),
            Text(
                "Info.instance.actualDpSize.height=${Info.instance.actualDpSize}"),
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
//              height: Info.instance.bodyMaxLength-kToolbarHeight,
              height: Info.instance.bodyMaxLength,
              child: Text("body${Info.instance.bodyMaxLength}")),
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
            height: Info.instance.uiBlueprints.length,
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
            height: Info.instance.bodyMaxLength - kToolbarHeight,
            color: Colors.red,
            child: Text("${_getText()}"
                "PinTenonWidget测试 ${MediaQuery.of(context).padding.vertical}"),
          ),
        ],
      ),
    );
  }

  String _getText() {
    StringBuffer sb = new StringBuffer();
    sb.write("int: ${getT<int>()} ${1.runtimeType.toString()} \n");
    sb.write("String: ${getT<String>()} ${"".runtimeType.toString()} \n");
    sb.write(
        "dynamic: ${getT<dynamic>()} ${dynamic.runtimeType.toString()} \n");
    sb.write("List<String>: ${getT<List<String>>()} ${[
      ""
    ].runtimeType.toString()} \n");
    sb.write(
        "List<String>: ${getT<List<String>>()} ${List<String>().runtimeType.toString()} \n");
    sb.write("bool: ${getT<bool>()} ${true.runtimeType.toString()} \n");
    return "${sb.toString()}";
  }

  getT<T>() {
    return T.runtimeType.toString();
  }
}
