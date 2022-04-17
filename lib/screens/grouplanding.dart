//Landing page of a Group
import 'package:flutter/material.dart';

class GroupLanding extends StatefulWidget {
  const GroupLanding({Key? key}) : super(key: key);
  static const routeName = '/grouplandingPage';
  @override
  State<GroupLanding> createState() => _GroupLandingState();
}

class _GroupLandingState extends State<GroupLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: Text("nothing"),
      ),
    );
  }
}
