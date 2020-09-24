import 'package:flutter/material.dart';
import 'package:langtest/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleView(){
    setState(() {
      showSignin = ! showSignin;

    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignin){
      return Login(toggleView: toggleView);
    } else{
      //return Register(toggleView: toggleView);
    }
  }
}