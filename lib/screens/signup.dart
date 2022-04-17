import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentors/modal/register_request_model.dart';
import 'package:mentors/screens/otppage.dart';
import 'package:mentors/services/api_service.dart';
import 'package:sms_autofill/sms_autofill.dart';

import './tabs.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import './createprofile.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  static const routeName = '/SignupPage';
  final sigunupform = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pswd = TextEditingController();
  TextEditingController confirmpswd = TextEditingController();
  bool isloading = false;
  /*List<Widget> tab = [
    const Tab(text: "PHONE NUMBER",),
    const Tab(text: "EMAIL ADDRESS"),
  ];*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //ADD METHOD TO VALIDATE AND SAVE FORM
    final curuser = Provider.of<DummyData>(context);

    return Scaffold(
      key: _scaffoldkey,
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.person_sharp,
                      size: 100,
                      color: Colors.black,
                    ),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  )
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          //foregroundColor: Colors.black,
                          bottom: TabBar(
                              indicatorColor: Colors.black,
                              labelStyle: TextStyle(color: Colors.black),
                              unselectedLabelStyle:
                                  TextStyle(color: Colors.grey),
                              labelColor: Colors.black,
                              tabs: [
                                Tab(
                                  text: "PHONE NUMBER",
                                ),
                                Tab(
                                  text: "EMAIL ADDRESS",
                                )
                              ])),
                      body: TabBarView(
                        children: [Tab1(), Tab2()],
                      ),
                    ),
                  )),
              /*Form(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "email"),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "pswd"),
                        controller: pswd,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                          decoration: InputDecoration(hintText: "Confirm pswd"),
                          controller: confirmpswd,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                  ],
                ),
                key: sigunupform,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: isloading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        child: Text(('Continue'),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          if (pswd.text == confirmpswd.text) {
                            setState(() {
                              isloading = true;
                            });
                            curuser
                                .registeruser(email.text, pswd.text)
                                .then((_) {
                              curuser.currentUser(email.text);
                              // Navigator.pushReplacement(context,
                              //  MaterialPageRoute(builder: (context) => const Home()));
                              setState(() {
                                isloading = false;
                              });
                              Navigator.of(context)
                                  .pushNamed(EditProfile.routeName);
                            }).catchError((error) {
                              setState(() {
                                isloading = false;
                              });
                              //showDialog(context: context, builder: builder)
                              //print(error);
                              _scaffoldkey.currentState!.showSnackBar(SnackBar(
                                //NULL CHECK???
                                content:
                                    Text("An error occured while Registering"),
                                behavior: SnackBarBehavior.floating,
                                elevation: 6.0,
                                duration: Duration(seconds: 1),
                              ));
                            });
                          }
                        },
                      ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pswd = TextEditingController();
  TextEditingController confirmpswd = TextEditingController();
  bool isenabledphone = false;
  bool isenabledemail = false;
  bool isloading = false;
  bool saveform() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

/*
  String? get errText {
    // at any time, we can get the text from _controller.value.text
    final text = phone.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length != 10) {
      return 'Invalid phone number';
    }
    // return null if the text is valid
    return null;
  }*/
  CreateOtpModel? model;
  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(),
                    //errorText: errText,
                  ),
                  controller: phone,
                  //enabled: isenabledphone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter phone number";
                    }
                    if (value.length != 10) {
                      return "Invalid phone number";
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "password",
                    helperText: "6 or more chars",
                  ),
                  controller: pswd,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 6) {
                      return "atleast 6 chars long";
                    }
                  },
                  onFieldSubmitted: (_) => saveform(),
                ),
              ],
            )),
        SizedBox(
          height: 5,
        ),
        isloading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: Text(('Next'),
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  /*if (saveform()) {
                    setState(() {
                      isloading = true;
                    });
                    curuser.registeruser(phone.text, pswd.text).then((_) {
                      curuser.currentUser(phone.text);
                      // Navigator.pushReplacement(context,
                      //  MaterialPageRoute(builder: (context) => const Home()));
                      setState(() {
                        isloading = false;
                      });
                      Navigator.of(context).pushNamed(EditProfile.routeName,arguments: {'id':phone.text,'password':pswd.text});
                    }).catchError((error) {
                      setState(() {
                        isloading = false;
                      });*/
                  if (saveform()) {
                    setState(() {
                      isloading = true;
                    });
                    model =
                        CreateOtpModel(phonenumber: phone.text, channel: "sms");
                    ApiService.createOtp(model!).then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Navigator.of(context).pushNamed(Otp.routeName,
                          arguments: {"id": phone.text, "password": pswd.text});
                    }).catchError((error) {
                      setState(() {
                        isloading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not send Otp')),
                      );
                    });
                  } else {
                    print("invalid form");
                  }
                  //showDialog(context: context, builder: builder)
                  //print(error);
                  /* _scaffoldkey.currentState!.showSnackBar(SnackBar(
                                //NULL CHECK???
                                content:
                                    Text("An error occured while Registering"),
                                behavior: SnackBarBehavior.floating,
                                elevation: 6.0,
                                duration: Duration(seconds: 1),
                              ));*/
                  //});
                })
      ],
    );
  }
}

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
  bool isloading = false;
  bool saveform() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(),
                  ),
                  controller: email,
                  //enabled: isenabledphone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email address";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "password",
                    helperText: "6 or more chars",
                  ),
                  controller: pswd,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 6) {
                      return "atleast 6 chars long";
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (_) => saveform(),
                ),
              ],
            )),
        SizedBox(
          height: 5,
        ),
        isloading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: Text(('Next'),
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  /*
                  if (saveform()) {
                    setState(() {
                      isloading = true;
                    });
                    curuser.registeruser(email.text, pswd.text).then((_) {
                      curuser.currentUser(email.text);
                      // Navigator.pushReplacement(context,
                      //  MaterialPageRoute(builder: (context) => const Home()));
                      setState(() {
                        isloading = false;
                      });
                      Navigator.of(context).pushNamed(EditProfile.routeName);
                    }).catchError((error) {
                      setState(() {
                        isloading = false;
                      });
                      //showDialog(context: context, builder: builder)
                      //print(error);
                      /* _scaffoldkey.currentState!.showSnackBar(SnackBar(
                                //NULL CHECK???
                                content:
                                    Text("An error occured while Registering"),
                                behavior: SnackBarBehavior.floating,
                                elevation: 6.0,
                                duration: Duration(seconds: 1),
                              ));*/
                    });
                  }*/
                  if (saveform()) {
                    // Navigator.of(context).pushNamed(CreateProfile.routeName,
                    //    arguments: {'id': email.text, 'password': pswd.text});
                  }
                })
      ],
    );
  }
}
