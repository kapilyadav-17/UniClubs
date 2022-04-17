import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import './tabs.dart';
import './addskills.dart';

//MAKE DIFFERENT FOR MAKE
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const routeName = '/EditProfilePage';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController major = TextEditingController();
  bool isloding = false;
  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    final u = curuser.loggedin;
    name.text = u.name;
    major.text = u.major;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Edit Profile"),
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isloding = true;
                });
                curuser.updateUser(u.id, name.text, major.text).then((_) {
                  setState(() {
                    isloding = false;
                  });
                  Navigator.of(context)
                      .pushReplacementNamed(TabsState.routeName);
                }).catchError((error) {
                  setState(() {
                    isloding = false;
                    //show snackbar,etc..
                  });
                  _scaffoldkey.currentState!.showSnackBar(SnackBar(
                    //NULL CHECK???
                    content: Text("Could not update"),
                    behavior: SnackBarBehavior.floating,
                    elevation: 6.0,
                    duration: Duration(seconds: 1),
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
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: () {},
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
                      decoration: InputDecoration(label: Text("Major")),
                      //initialValue: u.major,
                      controller: major,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AddSkill.routeName);
                            },
                            child: Text("Manage Skills"))
                      ],
                    )
                  ],
                )),
              ),
            ),
    );
  }
}
