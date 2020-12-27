import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langtest/games/matching.dart';
import 'package:langtest/games/voice_to_spell.dart';
import 'package:langtest/points_report.dart';
import 'package:langtest/games/puzzle_word.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/mystyle.dart';
import 'package:langtest/wordlist.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
              child: IconButton(
                icon: Icon(Icons.exit_to_app,semanticLabel: 'خروج',),
                iconSize: 30,
                onPressed: (){
                  showAlertDialog(context, 'أنت على وشك الخروج من التطبيق!');
                },
              )
          ),
          title: Text('مرحبا ' +  username),
          titleSpacing: 5,
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.report),
              iconSize: 30,
              tooltip: 'تقرير',
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PointReport()));
              },
            ),
            IconButton(
              icon:Icon( Icons.format_list_bulleted),
              iconSize: 30,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WordList()));
              },
            )
          ],
        ),

        body: Container(
          color: Colors.black,
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(

            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              SizedBox(height: 20.0),
              RaisedButton(
                highlightColor: Colors.green,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      'توصيل الكلمات',
                      style: myTextStyle.copyWith( fontSize: 25),),
                    SizedBox(width: 10,),
                    Image(
                      image: AssetImage('assets/matching.png'),
                      width: 50, height: 50,

                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Game('توصيل الكلمات')));
                },
                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                elevation: 5.0,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),

              ),
              SizedBox(height: 30.0),

              RaisedButton(
                highlightColor: Colors.green,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'معاني الكلمات',
                      style: myTextStyle.copyWith(color: Colors.black,fontSize: 25),),
                    SizedBox(width: 20,),
                    Image(
                      image: AssetImage('assets/text.png'),
                      width: 50, height: 50,

                    )
                  ],
                ),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzleWord()));
                },

                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                elevation: 5.0,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
              SizedBox(height: 30.0),

              RaisedButton(
                highlightColor: Colors.green,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'امـــلاء',
                      style: myTextStyle.copyWith(color: Colors.black,fontSize: 25),),
                    SizedBox(width: 20,),
                    Image(
                      image: AssetImage('assets/sound.png'),
                      width: 50, height: 50,

                    )
                  ],
                ),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VoiceToSpell()));
                },

                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                elevation: 5.0,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}