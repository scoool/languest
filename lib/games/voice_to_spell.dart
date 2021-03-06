import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts_improved/flutter_tts_improved.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/loading.dart';

class VoiceToSpell extends StatefulWidget {
  @override
  _VoiceToSpellState createState() => _VoiceToSpellState();
}

class _VoiceToSpellState extends State<VoiceToSpell> {
  bool loading = false;
  List<Words> _words ;
  String _word,_mean;
  int seed = 0;
  int counter = 0;
  int _help =0;
  int _wordLength = 0;
  AudioCache _audio= AudioCache();

  TextEditingController _wordController= TextEditingController();
  FlutterTtsImproved tts = FlutterTtsImproved();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  void  init() async {

    loading = true;
    _words = List<Words>();
    _wordController.clear();

    bringWordToPlayFuture(language,10).then((onValue){

      _words.addAll(onValue);
      setState(() {
        _word = _words[counter].word;
        _wordLength = _word.length;
        _mean = _words[counter].mean.trim();
        loading=false;

      });
      // myMap = Map.fromIterable(_words, key:(v) => v.word, value:(v) => v.mean);
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        appBar: AppBar(
          title: Text('النقاط: ${seed  ?? 0}     الكلمة:${counter}'),
          leading:  IconButton(
            icon:  Icon(Icons.arrow_back),
            onPressed: () {
              if (counter > 0){
                ADD_POINTS(seed.toString(), 'اسمع واكتب').then((onValue){
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

                setState(()  {
                  init();
                });
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.error),
              onPressed: (){
                setState(() {

                  if(_help < _word.length){

//                    nameHolder.text +=_word.substring(_help,_help+1);
                    int x = _wordController.text.length;

                    showToastMessage(_word.substring(x,x+1));
                    _help +=1;
                    seed -=1;
                  } else {
                    showToastMessage('اضغط موافق');
                  }
                });
              },
            )
          ],
        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              OutlineButton(
                  child: Image(
                    width: 100,
                    alignment: Alignment.center,
                    image: AssetImage('assets/sound.png'),
                  ),
                  onPressed:(){
                    print(_mean);

                    tts.setLanguage(language);
                    tts.setPitch(1);
                    tts.setSpeechRate(0.5);
                    tts.speak(_mean);
                  }
              ),
              SizedBox(height: 50,),
              SizedBox(
                width: 300 ,

                child: TextField(
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.done,

                  controller: _wordController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text ,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize:30,color: Colors.brown,),
                  onChanged: (val){
                    setState(() {
                      // nameHolder.text = val;
                    });
                  },
                ),
              ) ,


              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    RaisedButton(

                      onPressed: (){
                        if (_wordController.text != ''){
                          if (_wordController.text.toLowerCase() == _mean.toLowerCase() ){
                            _wordController.clear();

                            seed +=1;
                            _audio.play('good_job.mp3');

                            showToastMessage('أحسنت');
                            setState(() {
                              loading = true;
                              counter +=1;
                              _help =0;
                            });
                            init();

                          }else{
                            seed -=1;
                            _audio.play('slap_sound.mp3');

                            showToastMessage('جواب خاطئ');
                          }
                        }else{
                          showToastMessage('لم تجب على السؤال');
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.rtl,

                        children: <Widget>[
                          Text('موافق', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,),
                          Icon(Icons.check_circle,size: 50, ),
                        ],
                      ),
                      elevation: 5,

                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
