import 'dart:convert';

RegisterResponseModel registerResponsejson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.token,
    required this.userid,
    //required this.expirydate,
  });
  late final String message;
  late final String token;
  late final String userid;
  //late final DateTime expirydate;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token']; //if userid already exist
    userid = json['userid'];
    //expirydate = json['expirydate'];
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

class VerifyOtpModel {
  VerifyOtpModel({
    required this.phonenumber,
    required this.code,
  });
  late final String phonenumber;
  late final String code;

  //late final DateTime expirydate;

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phonenumber'] = phonenumber;
    _data['code'] = code;

    return _data;
  }
}
