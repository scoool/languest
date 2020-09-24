import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:langtest/module/user.dart';
import 'package:langtest/services/global.dart' as Global;

const ROOT = 'http://jeebzoon.com/languest/jsonUsers.php';
//http://10.0.2.2/PHP/langtest/jsonUsers.php
//http://langtest.albae3.com/jsonUsers.php

Future<List<User>> loginuser(String username, String password) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'LOGIN';
    map['user'] = username;
    map['pass'] = password;

    final response = await http.post(ROOT, body: map);

    if (200 == response.statusCode) {

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<User> list = parsed.map<User>((json) => User.fromJson(json)).toList();

      return list;

    } else {
      return List<User>();
    }
  } catch (e) {
    return List<User>();
  }
}

List<Userid> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Userid>((json) => Userid.fromJson(json)).toList();
}

Future<String> register( String nickname, String password) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'REGISTER';
    map['name']= nickname;
    map['pass']= password;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {

      return 'success';
    } else {
      return 'error';
    }
  } catch (e) {
    return e.toString();
  }
}

Future<List<Words>> getWords() async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'GET_WORDS';
    map['lang'] = Global.language;
    map['user_id'] = Global.userid;

    final response = await http.post(ROOT, body: map);

    if (200 == response.statusCode) {

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Words> list = parsed.map<Words>((json) => Words.fromJson(json)).toList();
      return list;

    } else {
      return List<Words>();
    }
  } catch (e) {

    return List<Words>();
  }
}

Future<String> AddWordFuture( String word, String mean, String lang) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'ADD_WORDS';
    map['word']= word;
    map['mean']= mean;
    map['lang'] = lang;
    map['user_id'] = Global.userid;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {

      return 'success';
    } else {
      return 'error';
    }
  } catch (e) {

    return e.toString();
  }
}

Future<String> EditWordFuture( String new_word, String new_mean, String old_word, String old_mean) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'Edit_WORDS';
    map['new_word']= new_word;
    map['new_mean']= new_mean;
    map['old_word'] = old_word;
    map['old_mean'] = old_mean;
    map['user_id'] = Global.userid;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {
      return response.body;
    } else {

    return 'error';
    }

  } catch (e) {

    return e.toString();
  }
}

Future<String> DeleteWordFuture( String word, String mean) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'DELETE_WORDS';
    map['word']= word;
    map['mean']= mean;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {

      return response.body;
    } else {

      return 'error';
    }
  } catch (e) {

  return e.toString();
  }
}

// game begin
Future<List<Words>> bringWordToPlayFuture( String lang,int limit) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'GET_WORD_TOPLAY';
    map['lang'] = lang;
    map['user_id'] = Global.userid;
    map['limit'] = limit.toString();


    final response = await http.post(ROOT, body: map);
    if (200 == response.statusCode) {

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Words> list = parsed.map<Words>((json) => Words.fromJson(json)).toList();
      return list;

    } else {

      return List<Words>();
    }
  } catch (e) {

    return List<Words>();
  }


}

Future<String> ADD_POINTS(  String points, String game) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'ADD_POINTS';
    map['point_date']= DateTime.now().toString();
    map['user_id'] = Global.userid;
    map['lang'] = Global.language;
    map['points']= points;
    map['game'] = game;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {

      return 'done';
    } else {
      return 'error';
    }
  } catch (e) {
    return e.toString();
  }
}

Future<List<Points>> getPoints() async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'GET_POINTS';
    map['user_id'] = Global.userid;
    map['lang'] = Global.language;

    final response = await http.post(ROOT, body: map);

    if (200 == response.statusCode) {

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Points> list = parsed.map<Points>((json) => Points.fromJson(json)).toList();

      return list;

    } else {
      return List<Points>();
    }
  } catch (e) {
    return List<Points>();
  }
}

Future<String> DeletePoints( ) async {
  try {
    var map = Map<String, dynamic>();
    map['action'] = 'DELETE_POINTS';
    map['user_id'] = Global.userid;
    map['lang'] = Global.language;

    final response = await http.post(ROOT, body: map);
    //List<User> list = parseResponse(response.body);

    if (200 == response.statusCode) {

      return response.body;
    } else {

      return 'error';
    }
  } catch (e) {

    return e.toString();
  }
}
