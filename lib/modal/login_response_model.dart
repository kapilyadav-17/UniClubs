import 'dart:convert';

LoginResponseModel loginResponsejson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.token,
    required this.userid,
    // required this.expirydate,
  });
  late final String message;
  late final String token;
  late final String userid;
  //late final DateTime expirydate;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userid = json['userid'];
    // expirydate = json['expirydate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['token'] = token;
    _data['userid'] = userid;
    //_data['expirydate'] = expirydate;
    return _data;
  }
}
