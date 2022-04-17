import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentors/modal/register_response_model.dart';
import 'package:mentors/screens/createprofile.dart';
import 'package:mentors/services/api_service.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);
  static const routeName = '/otpPage';
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otp = TextEditingController();
  VerifyOtpModel? model;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map; //null check???
    final email = args["id"].toString();
    final password = args["password"].toString();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height - safePadding,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.05),
          child: Center(
            child: isloading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'OTP Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Please enter the Otp sent on xxxxxxxxxx ',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      /*PinFieldAutoFill(
                  autoFocus: true,
                  codeLength: 4,
                  keyboardType: TextInputType.number,
                  controller: otp,
                  //enableInteractiveSelection: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]+"))
                  ],
                 
                ),*/
                      TextFormField(
                        maxLength: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide()),
                        ),
                        controller: otp,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (otp.text.length == 4) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            model = VerifyOtpModel(
                                phonenumber: email, code: otp.text);
                            setState(() {
                              isloading = true;
                            });
                            ApiService.verifyOtp(model!).then((value) {
                              setState(() {
                                isloading = false;
                              });
                              Navigator.of(context).pushNamed(
                                  CreateProfile.routeName,
                                  arguments: {
                                    "id": email,
                                    "password": password
                                  });
                            }).catchError((error) {
                              setState(() {
                                isloading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('OTP verification failed')),
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Enter valid OTP.')),
                            );
                          }
                        },
                        child: Container(
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFF4FBB38)),
                          child: const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
