//import 'dart:developer';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentors/screens/fake.dart';
import 'package:mentors/services/shared_service.dart';
import 'package:provider/provider.dart';
import './signup.dart';
import './tabs.dart';
import '../modal/dummydata.dart';
import '../modal/login_request_model.dart';
import '../services/api_service.dart';

class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  static const routeName = '/loginPage';
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final loginform = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
  bool isobsecure = true;
  bool ischecked = true;
  bool isauthenticating = false;
  bool saveform() {
    if (loginform.currentState!.validate()) {
      return true;
    }
    return false;
  }

  LoginRequestModel? model;

  @override
  Widget build(BuildContext context) {
    //ADD METHOD TO VALIDATE AND SAVE FORM
    // TODO: implement build
    final curuser = Provider.of<DummyData>(context);
    var id;
    var result;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //Another exception was thrown: Incorrect use of ParentDataWidget.
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RInsta',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    child: Text(('Join now'),
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                    onPressed: () {
                      //Navigator.pushReplacement(context,
                      //MaterialPageRoute(builder: (context) => const Home()));
                      Navigator.of(context).pushNamed(SignupState.routeName);
                    }, //use row to show text and button and bottom right
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Sign in",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Email or Phone"),
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter an email.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isobsecure = !isobsecure;
                                  });
                                },
                                icon: isobsecure
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                          ),
                          controller: pswd,
                          obscureText: isobsecure,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a password.";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => saveform()),
                    )
                  ],
                ),
                key: loginform,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: ischecked,
                    onChanged: (newvalue) {
                      setState(() {
                        ischecked = newvalue!;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  const Text(
                    'Remember me.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Learn more')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Forgot password?')),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //  MaterialPageRoute(builder: (context) => const Home()));

                  if (saveform()) {
                    setState(() {
                      isauthenticating = true;
                    });
                    loginform.currentState!.save();
                    id = email.text;
                    model =
                        LoginRequestModel(userid: email.text, pass: pswd.text);
                    ApiService.login(context, model!).then((_) {
                      setState(() {
                        isauthenticating = false;
                        //curuser.currentUser(id);
                      });
                      ApiService.profile(SharedService.token.toString())
                          .then((value) {
                        if (value) {
                          Navigator.of(context)
                              .pushReplacementNamed(Fake.routeName);
                        } else {
                          print('profile page could not open');
                        }
                      });
                    });

                    /*if (result == 1) {
                      print("navigated");
                      curuser.currentUser(id);
                      Navigator.of(context)
                          .pushReplacementNamed(TabsState.routeName);
                    }*/
                  }
                },
                child: isauthenticating
                    ? CircularProgressIndicator()
                    : Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all()),
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(
                    // indent: 2,
                    //endIndent: 2,
                    color: Colors.grey,
                    //height: 2,
                  ),
                  Text(
                    'or',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Divider(
                    //indent: 2,
                    //endIndent: 2,
                    color: Colors.grey,
                    //height: 2,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all()),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all()),
                  child: Text(
                    'Sign in with Apple',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
