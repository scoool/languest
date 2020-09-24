import 'package:flutter/material.dart';
import 'package:langtest/home.dart';
import 'package:langtest/login.dart';
import 'package:provider/provider.dart';
import 'package:langtest/module/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);
    if (user == null){
      return Login();
    } else {
      return Home();
    }

  }
}
