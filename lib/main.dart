import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      title: 'New Emulator',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // method 1
  StreamController _countNumbers = StreamController();

  addData() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      _countNumbers.sink.add(i);
    }
  }

  // method 2

  Stream<int> myNumbers() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData(); //method 1
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _countNumbers.close(); //method1
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Streams"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: myNumbers().map((event) => "number $event"),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text("hey, an error occured");
            else if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            return Text("${snapshot.data} ..");
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
