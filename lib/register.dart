import 'package:flutter/material.dart';
import 'package:langtest/login.dart';
import 'package:langtest/services/mysql.dart';
import 'package:langtest/services/shared.dart';
import 'package:langtest/style/mystyle.dart';


class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();
  bool loadingSpin= false;

  String   _nickname ='', _password ='',  error='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('تسجيل جديد'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            iconSize: 50.0,
            padding: EdgeInsets.only(right: 20.0),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login() ),
              );
            },
          )
        ],
      ),
      body: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                SizedBox(height: 100,),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: textDetailDecoration.copyWith(hintText: 'اسم المستخدم'),
                    validator: (val) => val.isEmpty? 'لا يمكن ترك الحقل فارغ' : null,
                    onChanged: (val){
                      setState(() {
                        _nickname=val;
                      });
                    },
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextFormField(

                    textAlign: TextAlign.center,
                    decoration: textDetailDecoration.copyWith(hintText: 'كلمة المرور'),
                    validator: (val) => val.isEmpty? 'لا يمكن ترك الحقل فارغ' : null,
                    onChanged: (val){
                      setState(() {
                        _password=val;
                      });
                    },
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: FlatButton(

                    onPressed:() async{

                      if (_formKey.currentState.validate()) {
                        String _encryptedpassword = encryptPassword(_password);

                        register( _nickname,_encryptedpassword).then((value){
                          print(value);
                          if (value == 'success'){
                           showToastMessage(  'تم التسجيل بنجاح');
                            Navigator.of(context).pop();
                          }else{
                            showToastMessage( 'خطأ في التسجيل .. /n تأكد من استخدام حروف انجليزية');
                          }
                        }
                        ).catchError((onError){
                          showToastMessage(onError.toString());
                        });
                        setState(() {
                          loadingSpin = true;
                        });
                      }
                    },

                    padding: EdgeInsets.all(12.0),
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    child:Text('تسجيل ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
                    ),

                  ),
                ),
                Center(

                ),
                Text(
                  error,
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
                )

              ],

            ),
          )
      ),
    );
  }
}
