import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts_improved/flutter_tts_improved.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/mystyle.dart';
import 'package:translator/translator.dart';

class AddWords extends StatefulWidget {

  @override
  _AddWordsState createState() => _AddWordsState();
}

class _AddWordsState extends State<AddWords> {
  final _formKey = GlobalKey<FormState>();
  String word,mean;
  TextEditingController _wordController= TextEditingController();
  TextEditingController _meanController= TextEditingController();
  FlutterTtsImproved tts = FlutterTtsImproved();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة كلمة'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50,),
                TextFormField(
                  controller: _wordController,
//                  initialValue: word ?? '',
                  onChanged: (val){
                    setState(() {
                      word = val.trim();
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: textDetailDecoration.copyWith(hintText: 'الكلمة'),
                  style: myTextStyle.copyWith(fontSize: 24.0),
                  validator: (value){
                    if(value.isEmpty){
                      return 'أدخل كلمة';
                    }
                    return null;
                  },

                ),
                IconButton(
                  icon: Icon(Icons.language),
                  iconSize: 40,
                  color: Colors.deepOrangeAccent,
                  tooltip: 'ترجمة قوقل',
                  onPressed: (){
                    final translator = GoogleTranslator();
                    translator.translate(word, to: language).then((onValue){
                          setState(() {

                            _meanController.text = onValue.text;
                            mean = onValue.text;
                          });
                    });

                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(

                  controller: _meanController,
                 // initialValue: mean ?? '',
                  onSaved: (val){
                    setState(() {
                      mean = val.trim();
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: textDetailDecoration.copyWith(hintText: 'معناها'),
                  style: myTextStyle.copyWith(fontSize: 24.0),
                  validator: (value){
                    if(value.isEmpty){
                      return 'أدخل المعنى';
                    }
                    return null;
                  },
                ),
                IconButton(
                  onPressed: (){
                    tts.setLanguage(language);
                    tts.setPitch(1);
                    tts.speak(_meanController.text);
                  },
                  icon: Icon(
                    Icons.mic,
                    size: 40,
                  ),
                ) ,
                SizedBox(height: 20.0,),
                FlatButton(
                  onPressed:  ()  {
                    AddWordFuture(word, mean, language).then((value){

                      if(value=='success'){
                        showToastMessage('تم اضافة الكلمة بنجاح');
                        setState(() {
                          _wordController.clear();
                          _meanController.clear();

                          word='';
                          mean='';
                        });
                      } else {
                        showToastMessage('حدث خطأ ربما الكلمة مكررة');

                      }
                    });
                    //showToastMessage('تمت الاضافة بنجاح');

                  },
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  padding: EdgeInsets.all(12.0),
                  child:Text(' اضــــافـــة',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white)
                  ),
                ), ],
            ),
          ),
        ),
      ),
    );
  }
}
