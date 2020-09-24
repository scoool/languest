import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),

        body: SingleChildScrollView(
          child: Center(
            
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Container(
                    width: 300,
                    child: RaisedButton(
                      onPressed: (){

                      },
                      child: Text('اللغات',style: TextStyle(color: Colors.white,fontSize: 20),),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
