import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mentors/screens/fake.dart';
import 'package:mentors/services/api_service.dart';
import 'package:mentors/services/shared_service.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import './tabs.dart';
import '../modal/register_request_model.dart';

//MAKE DIFFERENT FOR MAKE
class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  static const routeName = '/CreateProfilePage';
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController major = TextEditingController();
  TextEditingController coursename = TextEditingController();
  bool isloding = false;
  RegisterRequestModel? model;
  late String courseid;
  late String specializationid;
  Map<String, String> c = {'301': 'BTECH'};
  Map<String, String> s = {
    '401': 'CSE',
    '402': 'ME',
    '403': 'EE',
    '404': 'ECE',
    '405': 'CE'
  };
  //Map courses = {'301': 'CE'};
  /*List coursedialogchild = courses.entries.map((key, value) {
                return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, key);
                  },
                  child: const Text(value),
                );
              }).toList();*/
  Future<void> coursedialog() async {
    courseid = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 10,
            title: Text('Pick your Course'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '301');
                },
                child: const Text(
                  'BTECH',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        });
    coursename.text = c[courseid].toString();
  }

  Future<void> deptdialog() async {
    specializationid = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 10,
            title: Text('Pick your Specialization'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '405');
                },
                child: const Text(
                  'CE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '401');
                },
                child: const Text(
                  'CSE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '404');
                },
                child: const Text(
                  'ECE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '403');
                },
                child: const Text(
                  'EE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '402');
                },
                child: const Text(
                  'ME',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        });
    major.text = s[specializationid].toString();
  }

  File? pickedImage;
  Future<void> pickImage() async {
    final ImagePicker imgpick = ImagePicker();

    XFile? imagepicker = await imgpick.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (imagepicker != null) {
      setState(() {
        pickedImage = File(imagepicker.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map; //null check???
    final email = args["id"].toString();
    final password = args["password"].toString();
    //final curuser = Provider.of<DummyData>(context);

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Edit Profile"),
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isloding = true;
                });
                model = RegisterRequestModel(
                    userid: email,
                    pass: password,
                    coursename: courseid,
                    name: name.text,
                    specialization: specializationid);
                ApiService.register(context, model!).then((_) {
                  setState(() {
                    isloding = false;
                  });
                  //curuser.currentUser(email);
                  ApiService.profile(SharedService.token.toString())
                      .then((value) {
                    if (value) {
                      Navigator.of(context)
                          .pushReplacementNamed(Fake.routeName);
                    } else {
                      _scaffoldkey.currentState!.showSnackBar(SnackBar(
                        //NULL CHECK???
                        content: Text("Could not open profile"),
                        behavior: SnackBarBehavior.floating,
                        elevation: 6.0,
                        duration: Duration(seconds: 3),
                      ));
                    }
                  });
                }).catchError((error) {
                  setState(() {
                    isloding = false;
                    //show snackbar,etc..
                  });
                  _scaffoldkey.currentState!.showSnackBar(SnackBar(
                    //NULL CHECK???
                    content: Text("Could not register"),
                    behavior: SnackBarBehavior.floating,
                    elevation: 6.0,
                    duration: Duration(seconds: 5),
                  ));
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ))
        ],
      ),
      body: isloding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: pickedImage != null
                              ? FileImage(pickedImage!)
                              : null,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: pickImage,
                        child: Text("Change Profile Picture")),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(label: Text("Name")),
                      //initialValue: u.name,
                      controller: name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(label: Text("CourseName")),
                      //initialValue: u.name,
                      onTap: coursedialog,
                      controller: coursename,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(label: Text("Specialization")),
                      //initialValue: u.major,
                      onTap: deptdialog,
                      controller: major,
                    ),
                  ],
                )),
              ),
            ),
    );
  }
}
