import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:langtest/login.dart';
import 'package:langtest/services/global.dart';
// My IPv4 : 192.168.43.171
final String phpEndPoint = 'http://10.0.2.2/PHP/test/uploadimage.php';
final String nodeEndPoint = 'http://10.0.2.2/PHP/test/node.js';
File file;


var languages = ['english','Hawsa','French'];

void upload() {
  if (file == null) return;
  String base64Image = base64Encode(file.readAsBytesSync());
  String fileName = file.path.split("/").last;

  http.post(phpEndPoint, body: {
    "image": base64Image,
    "name": fileName,
  }).then((res) {
    print(res.statusCode);
  }).catchError((err) {
    print(err);
  });
}

String encryptPassword(password){

  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter =encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(password, iv: iv);
  return encrypted.base64;
}


void myShowDialog(context,title,body) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showToastMessage(String message) {

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );
}


class myIndicator extends StatelessWidget {
  const myIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200, height: 200,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
 showAlertDialog(BuildContext context,String message) {
  //bool act;
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("تراجع"),
    onPressed:  () {
      Navigator.of(context).pop();

    },
  );
  Widget continueButton = FlatButton(
    child: Text("استمر"),
    onPressed:  () {
      isLoggedIn =false;
      username='';
      userid = '';
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("تنبيه"),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  );


  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}
