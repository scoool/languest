import 'package:flutter/material.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';

class PointReport extends StatefulWidget {
  @override
  _PointReportState createState() => _PointReportState();
}

class _PointReportState extends State<PointReport> {
  Stream _stream ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _stream = getPoints().asStream();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete, size: 30, color: Colors.white,),
            onPressed: (){
              DeletePoints().then((val){
                if(val.contains('success')){
                  setState(() {
                    _stream = getPoints().asStream();

                  });

                }
              });
            },
          )
        ],
      ),

      body: SingleChildScrollView(

        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot){
            if (snapshot.hasData){

              List<Points> _list= snapshot.data;
              if (_list.length> 0){
                return DataTable(
                  horizontalMargin:1,
                  columns: [
                    DataColumn(
                        label: Text('التاريخ')
                    ),
                    DataColumn(
                        label: Text('اللعبة')
                    ),
                    DataColumn(label: Text('النقاط')),

                  ],
                  rows:
                  _list.map((item) => DataRow(
                      cells: [
                        DataCell(Text(item.point_date ?? '')),
                        DataCell(Text(item.game ?? '')),
                        DataCell(Text(item.points ?? '')),
                      ]
                  )).toList(),
                );

              }
            }
            return Center(
              child: Container(
                padding: EdgeInsets.only(top: 100),
                  child: Text('لا توجد بيانات',style: TextStyle(fontSize: 25),)),
            );
          },

        ),
      ),

    );
  }
}
