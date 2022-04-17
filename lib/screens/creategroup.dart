//ONLY FOR ADMIN
import 'package:flutter/material.dart';
import '../modal/dummydata.dart';
import '../modal/groupdata.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);
  static const routeName = '/creategroupPage';
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  TextEditingController name = TextEditingController();
  bool isloading = false;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final newgroup = Provider.of<GroupData>(context);
    final curuser = Provider.of<DummyData>(context).loggedin;
    final curuserid = curuser.id;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Create new Group"),
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isloading = true;
                });
                newgroup
                    .addGroup(name.text, curuserid, now.toString())
                    .then((_) {
                  setState(() {
                    isloading = false;
                  });
                  //newgroup.addMember(curuserid, groupid)
                  Navigator.of(context).pop();
                }).catchError((error) {
                  setState(() {
                    isloading = false;
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
                Icons.save,
                color: Colors.black,
              ))
        ],
      ),
      body: isloading == true
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
                        onPressed: () {}, child: Text("Change Group Picture")),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Group Name"),
                          border: OutlineInputBorder(),
                        ),
                        //initialValue: u.name,
                        controller: name,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
              ),
            ),
    );
  }
}
