import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../modal/user.dart';
import 'package:mentors/screens/visited.dart';
import '../modal/dummydata.dart';

class Connected extends StatefulWidget {
  const Connected({Key? key}) : super(key: key);
  static const routeName = '/connected';
  @override
  _ConnectedState createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  @override
  Widget build(BuildContext context) {
    final String currentuserid =
        ModalRoute.of(context)!.settings.arguments.toString();
    final alluser = Provider.of<DummyData>(context);
    final currentuserconn = alluser.getconn(currentuserid);
    final loggedinuser = alluser.loggedin;
    var name;
    var img;
    var subtitle;
    var id;
    void condetail(String id) {
      User details = alluser.getbyid(id);
      name = details.name;
      subtitle = details.major;
      id = details.id;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Connections",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            currentuserconn.length == 0
                ? Text("nothing")
                : Expanded(
                    child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      condetail(currentuserconn[i]);
                      return ListTile(
                          leading: CircleAvatar(
                            child: Text('KY'),
                            backgroundColor: Colors.green,
                            radius: 20,
                          ),
                          title: Text(name),
                          horizontalTitleGap: 30,
                          subtitle: Text(subtitle),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Visited.routeName, arguments: {
                              "id1": loggedinuser.id,
                              "id2": id,
                            }); //change
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          ));
                    },
                    itemCount: currentuserconn.length,
                  )),
          ],
        ),
      ),
    );
  }
}
