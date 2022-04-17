import 'package:flutter/material.dart';
import '../modal/dummydata.dart';
import 'package:provider/provider.dart';
import '../modal/user.dart';
import 'package:mentors/screens/visited.dart';

class Activity extends StatefulWidget {
  //const Activity({Key? key}) : super(key: key);
  static const routeName = '/activity';

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    final actvity = Provider.of<DummyData>(context);
    final loggeduser = actvity.loggedin;
    final loggedid = loggeduser.id;
    final actlist = actvity.getreqactivity(loggedid);
    var name;
    var img;
    var subtitle;
    var id;
    void condetail(String id) {
      User details = actvity.getbyid(id);
      name = details.name;
      subtitle = details.major;
      id = details.id;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Activity"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          actlist.length == 0
              ? Center(
                  child: Text(
                    "No Recent Activity",
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: actlist.length,
                    itemBuilder: (ctx, i) {
                      condetail(actlist[i]);
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('KY'),
                          backgroundColor: Colors.green,
                          radius: 20,
                        ),
                        title: Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            actvity.addcon(loggedid, actlist[i]);
                            //show new tile in place of this
                            //actvity.remreqactivity(loggedid, actlist[i]);
                          },
                          icon: Icon(Icons.check),
                        ),
                        horizontalTitleGap: 30,
                        subtitle: Text("has requested to connect with you"),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Visited.routeName, arguments: {
                            "id1": loggedid,
                            "id2": actlist[i],
                          }); //change
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
/*
 Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  actvity.remreqactivity(
                                      loggedid, actlist[i]); // form this list
                                  //change requested to request status
                                },
                                icon: Icon(Icons.close)),
                            SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                actvity.addcon(loggedid, actlist[i]);
                                //show new tile in place of this
                                //actvity.remreqactivity(loggedid, actlist[i]);
                              },
                              icon: Icon(Icons.check),
                            ),
                          ],
                        ),
*/
