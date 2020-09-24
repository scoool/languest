import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/wrapper.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _bushMessage = FirebaseMessaging();

  @override
  void initState(){
    super.initState();
    _bushMessage.getToken().then((onValue){
      print(onValue);
    });
  }

  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData( primarySwatch: Colors.deepOrange),
        home: Wrapper(
        )
      )
    );
  }
}

//MaterialApp(
//title: 'Langtest',
//theme: ThemeData(
//
//primarySwatch: Colors.deepOrange,
//),
//home:Wrapper(),
//);