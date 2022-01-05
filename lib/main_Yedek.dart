import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 10;
  int number = 10;
  StreamController _streamController = StreamController();

  void yayin() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      _streamController.sink.add(i);
    }
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(number.toString(),style: TextStyle(fontSize: 25.0),),
            ElevatedButton(
              onPressed: () {
                yayin();
                _streamController.stream.listen((event) {
                  print(event);
                  setState(() {
                    number=event;
                  });
                });

              },
              child: Text('Yayin'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                yayin();
                final Future<List> liste=_streamController.stream.toList();
                //var liste=_streamController.stream.toList();
                liste.then((value) => print(value));
                print(liste.runtimeType);
              },
              child: Text('Liste'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('yayın');
          _streamController.stream.listen((event) {
            print(event);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
