import 'package:flutter/material.dart';
import 'package:mentors/screens/addpost.dart';
import 'package:mentors/screens/creategroup.dart';
import './login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import '../widgets/post.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  static const routeName = '/homePage';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentBackPressTime;
  bool isloading = true; //circular
  Future<void> refreshposts(BuildContext context) async {
    await Provider.of<DummyData>(context, listen: false)
        .fetchtotalposts(); //set isloading to false in then//Ensure it is never zero
  }

  @override
  void initState() {
    Provider.of<DummyData>(context, listen: false).fetchtotalposts().then((_) {
      setState(() {
        isloading = false;
      });
    }).catchError((onError) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    //final u = curuser.loggedin;
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: 'Press again to Exit',
        );
        return Future.value(false);
      }
      return Future.value(true);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.brown,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Post.routeName);
              },
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshposts(context),
        child: WillPopScope(
          onWillPop: onWillPop,
          child: isloading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          //starts from 0 or 1??
                          return PostWidget(p: curuser.totalposts[i]);
                        },
                        itemCount: curuser.totalposts.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 30,
                ),
                alignment: Alignment.centerLeft,
              ),
              decoration: BoxDecoration(color: Colors.green.shade200),
            ),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              leading: Icon(
                Icons.settings,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log out',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            ListTile(
              title: Text('Groups',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              onTap: () {
                Navigator.of(context).pushNamed(CreateGroup.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
