import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langtest/add_words.dart';
import 'package:langtest/edit_words.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/loading.dart';

class WordList extends StatefulWidget {

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  List<Words> selectedItem = [];
  List<Words> items;
  int count = 0;
  bool loading=false;
  bool sort;

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        items.sort((a, b) => a.word.compareTo(b.word));
      } else {
        items.sort((a, b) => b.word.compareTo(a.word));
      }
    }
  }

  Future<List> stream;
  @override

  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text('قائمة الكلمات'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
            child: Text('المجموع: ${count.toString()}',
              style: TextStyle(fontSize: 16.0),),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon( Icons.add_box, size: 40,),
            onPressed: (){
//              if (user_role != 'admin') {
//                showToastMessage('لا توجد لديك صلاحية');
//                return;
//              }
              Navigator.push(

                  context,
                  MaterialPageRoute (builder: (context) => AddWords()));
            },
          ),

        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,

        child: StreamBuilder(

            stream: getWords().asStream(),
            builder: (context, snapshot){

              if (snapshot.hasData){
                List<Words> list = snapshot.data;
                if (list.length>0) {
                  count = list.length;

                  return createViewItem(list, context);
                }
              }
              return Column(
                children: <Widget>[
                  SizedBox(height: 50,),

                  Text('يجب اضافة كلمات', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  myIndicator(),
                ],
              );
            }
        ),
      ),

    );
  }

  Widget createViewItem(List<Words> list, BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DataTable(
              horizontalMargin: 8.0,
              sortColumnIndex: 0,
              sortAscending: sort?? true,

              columns: [

                DataColumn(label: Container(width: 20, child: Text('الكلمة', textAlign: TextAlign.center,)),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                    onSortColum(columnIndex, ascending);
                  },
                  numeric: false,
                ),

                DataColumn(label: Container(width:30, child: Text('معناها', textAlign: TextAlign.center,)), ),
                DataColumn(label: Text('', textAlign: TextAlign.center,)),
                DataColumn(label: Text(''))
              ],
              rows:
              list.map((item) => DataRow(

                  cells: [

                    DataCell(
                        Container(
                          width: 50,
                          child:  Text(item.word, textAlign: TextAlign.center,),
                        )
                    ),
                    DataCell(
                        Container(
                            width: 50,
                            child: Text(item.mean, textAlign: TextAlign.center,)
                        )
                    ),
                    DataCell(
                        Container(
                          width: 30,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.deepOrange,

                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:(context) => EditWords(item.word, item.mean) ));

//    if (user_role == 'admin'){
//    } else {
//                                showToastMessage('لا توجد لديك صلاحية');
//                              }

                            },
                          ),
                        )

                    ),
                    DataCell(
                      
                        Container(
                          margin: EdgeInsets.all(0),
                          width: 30,
                          child: IconButton(
                            hoverColor: Colors.red,
                            color: Colors.deepOrange,
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              DeleteWordFuture(item.word, item.mean).then((v){

                                showToastMessage('تم الحذف بنجاح');
                                setState(() {
                                  getWords();

                                });
                              });
//                              if (user_role == 'admin'){
//                              } else {
//                              showToastMessage('لا توجد لديك صلاحية');
//
//                            }

                            },
                          ),
                        )
                    )
                  ]
              )).toList(),
            ),
          ],
        ),
      ),
    );
//
  }

  Future<Null> _refresh() async {
    setState(() {

    });
    Completer<Null> c = Completer<Null>();
    c.complete();

    return null;

  }
}

