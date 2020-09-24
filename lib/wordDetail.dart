import 'package:flutter/material.dart'  ;
import 'package:langtest/module/sql_words.dart';

class WordDetail extends StatefulWidget {
  final String appBarTitle;
  final SQLiteWords word;

  WordDetail(this. word, this.appBarTitle);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
