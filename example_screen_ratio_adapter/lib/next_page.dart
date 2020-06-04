import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("@@MediaQuery ${MediaQuery.of(context).size}");
    print("@@MediaQuery ${MediaQuery.of(context).padding.top}");
    print("@@MediaQuery ${MediaQuery.of(context).devicePixelRatio}");
    print("@@MediaQuery ${MediaQuery.of(context).textScaleFactor}");
    return Scaffold(
      appBar: AppBar(
        title: Text("next page"),
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
