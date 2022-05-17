import 'package:flutter/material.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

///设计稿尺寸，单位应是pt或dp
//var uiSize = BlueprintsRectangle(300, 510);
//var uiSize = BlueprintsRectangle(721, 628);
var uiSize = BlueprintsRectangle(414, 878);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  FxWidgetsFlutterBinding.ensureInitialized(
      uiBlueprints: uiSize, enableLog: true);
  runApp(MyApp());
}
// void main() {
//   return runFxApp(MyApp(),
//       uiBlueprints: uiSize, onEnsureInitialized: () {}, enableLog: true);
// }

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
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

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
        title: Text(widget.title ?? ""),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage();
                }));
              },
              child: Text("NextPage")),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'MediaQuery.of(context).size=${MediaQuery.of(context).size}',
              ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage2();
                }));
              },
              child: Text("NextPage"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage3();
                }));
              },
              child: Text("NextPage3"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NextPage4();
                }));
              },
              child: Text("NextPage4"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RepetitionLine();
                }));
              },
              child: Text("RepetitionLine"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RepetitionLine extends StatelessWidget {
  RepetitionLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double value = 50.6;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Scaffold(
              appBar: AppBar(
                  title: Text('复现线条间隙问题'),
                  elevation: 0,
                  backgroundColor: Color(0xFF007D5F)),
              backgroundColor: Color(0xFF007D5F),
              body: Container(color: Color(0xFF007D5F), height: 200),
            ),
          ),
          SizedBox(height: 100),
          Container(color: Colors.green, height: 50),
          Container(color: Colors.green, height: 50),
          Container(color: Colors.green, height: 50),
          Container(color: Colors.green, height: value),
          Container(color: Colors.green, height: value),
          Container(color: Colors.green, height: value),
          Row(
            children: [
              Container(color: Colors.green, height: 50, width: value),
              Container(color: Colors.green, height: 50, width: value),
              Container(color: Colors.green, height: 50, width: value),
            ],
          )
        ],
      ),
    );
  }
}

class NextPage2 extends StatelessWidget {
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    print("build哈哈哈size=$size");
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("哈哈哈"),
      // ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            width: double.infinity,
            height: MediaQuery.of(context).padding.top,
          ),
//           Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).padding.top,
//               color: Colors.red),
          Container(
              color: Colors.deepPurpleAccent,
              width: double.infinity,
              height: Info.instance.bodyMaxLength,
              // height: Info.instance.uiBlueprints.length+Info.instance.deltaLength,
              // height: double.infinity,
              // height:size.height,
              child: Text(
                  "body${Info.instance.bodyMaxLength} kToolbarHeight=$kToolbarHeight MediaQuery.of(context).padding.top=${MediaQuery.of(context).padding.top}")),
        ],
      ),
    );
  }
}

class NextPage3 extends StatelessWidget {
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
        "List<String>: ${getT<List<String>>()} ${<String>[].runtimeType.toString()} \n");
    sb.write("bool: ${getT<bool>()} ${true.runtimeType.toString()} \n");
    return "${sb.toString()}";
  }

  getT<T>() {
    return T.runtimeType.toString();
  }
}
