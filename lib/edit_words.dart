import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langtest/services/global.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/mystyle.dart';
import 'package:translator/translator.dart';

class EditWords extends StatefulWidget {
  String _word,_mean;
  EditWords(this._word,this._mean);

  @override
  _EditWordsState createState() => _EditWordsState();
}

class _EditWordsState extends State<EditWords> {
  String new_word,new_mean;
  TextEditingController _wordController= TextEditingController();
  TextEditingController _meanController= TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _meanController.text = widget._mean;
    _wordController.text = widget._word;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('تحرير الكلمة'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Form(

          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  SizedBox(height: 50,),

                  TextFormField(

                  controller: _wordController,
                    onChanged: (val){
                      setState(() {
                        new_word = val;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: textDetailDecoration.copyWith(hintText: 'الكلمة'),
                    style: myTextStyle.copyWith(fontSize: 24.0),
                    readOnly: true,
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
                      translator.translate(_wordController.text, to: language).then((onValue){
                        setState(() {
                          _meanController.text = onValue.text;
                          new_mean = onValue.text;
                        });
                      });

                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: _meanController,

                   // initialValue: widget._mean,
                    onSaved: (val){
                      setState(() {
                        new_mean = val;
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
                  SizedBox(height: 20.0,),
                  FlatButton(
                    onPressed:  () {

                      EditWordFuture(new_word ?? widget._word, new_mean?? widget._mean,widget._word, widget._mean).then((value){
                        showToastMessage(value);
                      });

                    },
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    padding: EdgeInsets.all(12.0),
                    child:Text(' تــحــديث',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )


    );
  }
}
