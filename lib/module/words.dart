import 'package:flutter/material.dart';

class ClassWords extends StatelessWidget {
  final String text;
  const ClassWords({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[700],

      child: Container(

        alignment:Alignment.center,
        height: 50,
        width: 150,

        padding: EdgeInsets.all(2.0),
        child: Text(text,
            style: TextStyle(fontSize: 18, color: Colors.white,  )),
      ),
    );
  }
}
