import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import '../modal/user.dart';
import 'dart:io';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);
  static const routeName = '/addpostpage';
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController txt = TextEditingController();
  //File image;
  var post;
  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    final u = curuser.loggedin;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "Share post",
          style: TextStyle(fontSize: 18),
        ),
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.grey,
            )),
        actions: [
          TextButton(
            onPressed: () {
              if (txt.text.isNotEmpty) {
                post = Posts(
                    crname: u.name,
                    crid: u.id,
                    postid: DateTime.now().toString(),
                    txt: txt.text);
                curuser.addPost(post);
                Navigator.of(context).pop();
              }

              //print(u.mypost.length);
            },
            child: Text(
              "Post",
              style: TextStyle(fontSize: 18),
            ),
            //disable ,enable
          ),
        ],
      ),
      //backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: CircleAvatar(
                    child: Text('KY'),
                    backgroundColor: Colors.green,
                    radius: 20,
                  ),
                  title: Text(u.name),
                  subtitle: Container(),
                ),
                Expanded(
                    child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: txt,
                  decoration: InputDecoration(
                      hintText: "What do you want to talk about?",
                      hintStyle: TextStyle(fontSize: 16)),
                  showCursor: true,
                  cursorHeight: 20,
                ))
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("Add HashTag"),
          ),
          Expanded(
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
                IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
                IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.more_horiz),
                    Container(),
                  ],
                ))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
        ],
      ),
    );
  }
}
