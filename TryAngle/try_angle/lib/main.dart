import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:try_angle/models/JsonResponse.dart';
import 'package:try_angle/network/NetworkRequester.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', subtitle: "Part 2"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, Key key2, this.subtitle}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String subtitle;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items = [];

  _MyHomePageState() {
    requestNewData();
  }

  void requestNewData() {
    var requester = new Requester();
    requester.fetchData().then((responseObject) {
      changeResponseObject(responseObject);
    });
  }

  void changeResponseObject(JsonResponse responseObj) {
    // Invalidates data
    setState(() {
      items.add(responseObj);
    });
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
        title: Text(widget.title + widget.subtitle),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return RowElement(items[index]);
        },
        itemCount: items.length,
      ),
//      body: Center(
//
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Hit time',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestNewData,
        tooltip: 'Add new gif',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RowElement extends StatelessWidget {
  final responseObject;

  RowElement(this.responseObject);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(getTitle(responseObject)),
            (responseObject != null)
                ? CachedNetworkImage(
                    imageUrl: getImage(responseObject),
                    placeholder: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ));
  }
}

String getTitle(JsonResponse response) {
  if (response == null || response.title == null) {
    return "";
  }
  return "Test" + response.title;
}

String getImage(JsonResponse response) {
  if (response == null || response.gif == null) {
    return "";
  }
  return response.gif;
}
