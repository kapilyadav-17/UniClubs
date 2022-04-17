class LoginRequestModel {
  LoginRequestModel({
    required this.userid,
    required this.pass,
  });
  late final String userid;
  late final String pass;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userid'] = userid;
    _data['pass'] = pass;
    return _data;
  }
}
