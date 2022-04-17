import 'package:flutter/material.dart';
import '../services/shared_service.dart';
import 'package:provider/provider.dart';
import './login.dart';

class Fake extends StatelessWidget {
  const Fake({Key? key}) : super(key: key);
  static const routeName = '/fakePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fake page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('logout'),
          onPressed: () {
            Provider.of<SharedService>(context, listen: false).logout();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
    );
  }
}
