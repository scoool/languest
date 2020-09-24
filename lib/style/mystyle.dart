import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const dropdowninputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  alignLabelWithHint: true,

  hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.brown, ),

  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange, width:2.0,)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown, width:2.0,)
  ),

);

const textDetailDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  alignLabelWithHint: true,

  errorStyle: TextStyle(color: Colors.red,fontSize: 12.0),
  hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.brown, ),

  enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.deepOrange, width:1.0,)
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.brown, width:1.0,)
  ),

);

const myTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold
);

const myDivider = Divider(

    height: 5.0,
    indent: 20.0,
    endIndent: 20.0,
    thickness: 0.0,
    color: Colors.black38,
);

const mySizeBox= SizedBox(
  height: 20.0,
);

