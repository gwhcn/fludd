import 'package:flutter/material.dart';

import 'package:fludd/fludd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Fludd.registerApp(appId: "dingoauatepw43lhtws0gf");
    Fludd.responseFromAuth.listen((event) {
      print( event.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(onPressed: (){
            Fludd.sendAuth(bundleId: 'com.gwh.fluddExample').then((b){
              print("bbbb:$b");
            }).catchError((e){
              print("eee:$e");
            });
          }, child: Text("data")),
        ),
      ),
    );
  }
}
