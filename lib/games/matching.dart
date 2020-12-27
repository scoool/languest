import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/module/words.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/loading.dart';

class Game extends StatefulWidget {
  final String gamen_name;
  Game(this.gamen_name);

  @override
  _GameState createState() => _GameState();
}


class _GameState extends State<Game> {
//  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//  GlobalKey<RefreshIndicatorState>();
  final Map<String, bool> score = {};
  List<Words> _words ;
  Map myMap ;
  int seed = 0;
  int counter = 0;
  AudioCache _audio= AudioCache();
  bool loading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();

  }

  void  init() {
    _words = List<Words>();
    score.clear();
    seed++;
    loading = true;

     bringWordToPlayFuture(language,10).then((onValue){
      _words.addAll(onValue);
      setState(() {
        myMap = Map.fromIterable(_words, key:(v) => v.word, value:(v) => v.mean);
        loading=false;
      });

     });

  }
  Widget build(BuildContext context) {
    return loading ? Loading() : WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(

            title: Text('Score: ${counter ?? 0}'),
            leading:  IconButton(
              icon:  Icon(Icons.arrow_back),
              onPressed: () {
                if (counter > 0){
                  ADD_POINTS(counter.toString(), widget.gamen_name).then((onValue){
                    showToastMessage('تم تسجيل النقاط');
                    Future.delayed(Duration(seconds: 2)).then((onValue){
                      loading=true;

                      Navigator.pop(context);

                    });
                  }).catchError((onError){
                    showToastMessage(onError);
                  });
                } else {
                  Navigator.pop(context);
                }

      },
            ),
            actions: <Widget>[
              FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: (){

                  setState(() {
                    init();

                  });
                },
              ),

            ],
          ),

          body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: myMap?.keys?.map((f){

                      return Draggable<String>(
                        maxSimultaneousDrags: 1,
                        feedbackOffset: Offset.zero,
                        data: f,
                        child: ClassWords(text:score[f] == true ? '' : f),
                        feedback: ClassWords(text: f),

                        childWhenDragging: Container(width: 150,height: 50,),

                        onDragCompleted: (){

                          if (score[f] == true){
                            setState(() {
                              counter +=3;
                            });
                            _audio.play('good_job.mp3');
                          }
                        },
                        onDragEnd: (result){

                          if (!result.wasAccepted ){
                            setState(() {
                              counter -=1;
                            });
                            _audio.play('slap_sound.mp3');
                          }

                        },

                      );
                    })?.toList() ?? []),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: myMap?.keys?.map((f) => _buildDragTarget(f))?.toList() ?? []
                    ..shuffle(Random(seed)),
                )

              ])
      ),
    );
  }


  Widget _buildDragTarget(f){
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming,List rejected){

        if (score[f] == true) {

          return Container(
            child: Icon(Icons.insert_emoticon, size: 50, color: Colors.green,),
            alignment: Alignment.center,
            height: 50,
            width: 100,
          );

        } else{

          return Container(
            color: Colors.blueGrey,
            width: 150,
            height: 50,
            alignment: Alignment.center,
            child: Text(myMap[f],
              style: TextStyle( fontSize: 18, color: Colors.white,
              ),
            ),
          );
        }
      },
      onWillAccept: (data) => data == f,
      onAccept: (data) {

        setState(() {
          score[f] = true;

          if (score.length >= _words.length) {
            Container(
              child: Icon(Icons.thumb_up, color: Colors.green[700],size: 100,),
            );
            seed++;
          }
        });

      },

      onLeave: (data){

      },
    );
  }

}


