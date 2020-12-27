import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langtest/home.dart';
import 'package:langtest/module/user.dart';
import 'package:langtest/register.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/mystyle.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:language_pickers/languages.dart';
import 'services/global.dart' as Global;

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool loadingSpin= false;

  String email = '';
  String password = '';
  String error='';
  Language _selectedDropdownLanguage =  LanguagePickerUtils.getLanguageByIsoCode('sa');
  // It's sample code of Dropdown Item.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    // Global.isLoggedIn = false

    return WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        key: _scaffoldKey,

        appBar: AppBar(
          leading: Container(),
          title: Text(Global.appTitle ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingUp()));
                },
                icon: Icon(Icons.person_add),
                iconSize: 40,
              ),
            ),
          ],

        ),
        body: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 80, 25, 10),
                  child: TextFormField(
                    initialValue: '',
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next ,
                    decoration: textDetailDecoration.copyWith(hintText: 'اسم المستخدم'),
                    validator: (val) => val.isEmpty? 'لا يمكن ترك الخانة فارغة' : null,
                    onSaved: (val){
                      setState(() {
                        email= val;
                      });
                    },
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextFormField(
                    initialValue: '',
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next ,

                    decoration: textDetailDecoration.copyWith(hintText: 'كلمة المرور'),
                    validator: (val) => val.isEmpty? 'لا يمكن ترك الخانة فارغة' : null,
                    onSaved: (val){
                      setState(() {
                        password=val;
                      });
                    },
                    obscureText: true,
                  ),
                ),
//                Container(
//                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
//                    child: Center(child: Text('اختر لغتك ',style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),))),
//
//                Center(
//
//                  child: Container(
//                    height: 50,
//                    width: 300,
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                        border: Border.all(),
//                        borderRadius: BorderRadius.all(Radius.circular(10.0))
//                    ),
//                    child: LanguagePickerDropdown(
//
//                      initialValue: 'ar',
//
//                      itemBuilder: _buildDropdownItem,
//                      onValuePicked: (Language language) {
//                        _selectedDropdownLanguage = language;
//                        Global.user_lanuage = _selectedDropdownLanguage.isoCode;
//
//                      },
//                    ),
//                  ),
////
//                ),

                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Center(child: Text('اختر اللغة التي ترغب بتعلمها',style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),))),

                Center(

                  child: Container(
                    height: 50,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: LanguagePickerDropdown(

                      initialValue: 'en',

                      itemBuilder: _buildDropdownItem,
                      onValuePicked: (Language language) {
                        _selectedDropdownLanguage = language;
                        Global.language = _selectedDropdownLanguage.isoCode;

                      },
                    ),
                  ),
//
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
                  child: FlatButton(

                    onPressed:  ()   {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

//                        if(Global.language == Global.user_lanuage){
//                          showToastMessage('تأكد من اختيار لغتين مختلفتين');
//                          return;
//                        }

                        String Cryptedpassword = encryptPassword(password);

                        loginuser(email, Cryptedpassword).then((value){
                          List<User> _lst = value;

                          if (_lst.length > 0){
                            Global.isLoggedIn = true;
                            Global.userid = _lst[0].id;
                            Global.username = _lst[0].name;
                            Global.user_role = _lst[0].role;

                            var userid = _lst[0].id ;

                            if ( !userid.toString().contains('null')  ){

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()));
                            }
                          } else   {
                            showToastMessage('تأكد من اسم المستخدم أو كلمة المرور');
                          };
                        }).catchError((onError) => print(onError.toString()));
                        setState(() {
                          loadingSpin = true;
                        });
                      }

                    },

                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    padding: EdgeInsets.all(12.0),
                    child:Text(' دخول',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  error,
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
                )
              ],

            ),
          ),

        ),

      ),
    );
  }
}
