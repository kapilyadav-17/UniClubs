/*import 'api ==';
class SharedSevice{
  static Future<bool> isLoggedIn ()async{
    var isKeyExist = await APICacheManager().
  }
}

*/
import 'dart:async';
import 'dart:convert';
import 'package:mentors/modal/login_request_model.dart';
import 'package:mentors/modal/login_response_model.dart';
import 'package:mentors/modal/register_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedService with ChangeNotifier {
  static late String? token;
  static late String? userid;
  late String? password;
  static late DateTime expirydate;
  static late Timer? authTimer = null;

  Future<void> setlogindetails(LoginResponseModel model) async {
    final prefs = await SharedPreferences.getInstance();
    token = model.token;
    userid = model.userid;
    final n = DateTime.now();
    expirydate = n.add(const Duration(hours: 1));
    final userData = json.encode({
      'message': model.message,
      'token': model.token,
      'userid': model.userid,
      'expirydate': expirydate.toIso8601String(),
    });
    prefs.setString('userData', userData);

    autologout();
    print('done');
  }

  String? get user {
    if (userid != null) {
      return userid;
    }
    return null;
  }

  Future<void> logout() async {
    userid = null;
    token = null;
    //expirydate = null;
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
    notifyListeners();
    print('logout');
  }

  Future<void> register(RegisterResponseModel model) async {
    final prefs = await SharedPreferences.getInstance();
    token = model.token;
    userid = model.userid;
    final n = DateTime.now();
    expirydate = n.add(const Duration(hours: 1));
    final userData = json.encode({
      'message': model.message,
      'token': model.token,
      'userid': model.userid,
      'expirydate': expirydate.toIso8601String(),
    });
    prefs.setString('userData', userData);

    autologout();
  }

  Future<bool> tryautologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('p2');
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expdate = DateTime.parse(extractedUserData['expirydate']);
    if (expdate.isBefore(DateTime.now())) {
      print('p3');
      return false;
    }
    token = extractedUserData['token'].toString();
    userid = extractedUserData['userid'].toString();
    expirydate = expdate;
    autologout();
    print('p1');
    return true;
  }

  void autologout() {
    if (authTimer != null) {
      print('p4');
      authTimer!.cancel();
    }
    print('p5');
    final timetoexpiry = expirydate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timetoexpiry), logout);
  }
}
