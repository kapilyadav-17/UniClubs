class RegisterRequestModel {
  RegisterRequestModel({
    required this.userid,
    required this.pass,
    required this.name,
    required this.coursename,
    required this.specialization,
  });
  late final String userid;
  late final String pass;
  late final String name;
  late final String coursename;
  late final String specialization;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    pass = json['pass'];
    name = json['name'];
    coursename = json['coursename'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userid'] = userid;
    _data['pass'] = pass;
    _data['name'] = name;
    _data['coursename'] = coursename;
    _data['specialization'] = specialization;
    return _data;
  }
}

class CreateOtpModel {
  CreateOtpModel({
    required this.phonenumber,
    required this.channel,
  });
  late final String phonenumber;
  late final String channel;

  CreateOtpModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phonenumber'] = phonenumber;
    _data['channel'] = channel;

    return _data;
  }
}
