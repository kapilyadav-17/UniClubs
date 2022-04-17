import 'package:flutter/material.dart';
import 'package:mentors/screens/activity.dart';
import '../modal/dummydata.dart';
import 'package:provider/provider.dart';
import '../widgets/griditem.dart';

class Visited extends StatefulWidget {
  //Visited({required this.id});
  //final String id;
  static const routeName = '/visitedPage';

  @override
  _VisitedState createState() => _VisitedState();
}

class _VisitedState extends State<Visited> {
  bool request = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map; //null check???
    final routeargs = args["id1"].toString();
    final secondarg = args["id2"].toString();
    final visiteduser = Provider.of<DummyData>(context);
    final curvisiteduser = visiteduser.getbyid(secondarg);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(' '),
                        radius: 60,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: Text('KY'),
                        radius: 50,
                      ),
                      Positioned(
                        child: Container(
                          child: Text(curvisiteduser.name),
                        ),
                        bottom: 20,
                      )
                    ],
                    alignment: Alignment.center,
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.cast_for_education),
                          SizedBox(width: 5),
                          Text(curvisiteduser.major)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.link_sharp),
                          SizedBox(width: 5),
                          Text('Connections'),
                          SizedBox(width: 5),
                          Text('${curvisiteduser.con.length}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (visiteduser.isconnected(
                                  routeargs, secondarg)) {
                                //alert dialogue box//????requested h phir se build hoga toh request=0 ho jayega??
                                //call removecon
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Unfollow'),
                                    content: const Text(
                                        'You have make request again to connect'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Provider.of<DummyData>(context)
                                              .remcon(routeargs, secondarg);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                if (!request) {
                                  visiteduser
                                      .addreqactivity(secondarg, routeargs)
                                      .then((value) {
                                    setState(() {
                                      request = !request;
                                    });
                                  });
                                } //method is called for all data not for individual object
                                else {
                                  visiteduser
                                      .remreqactivity(secondarg, routeargs)
                                      .then((value) {
                                    setState(() {
                                      request = !request;
                                    });
                                  });
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            child: visiteduser.isconnected(routeargs, secondarg)
                                ? Text("Connected",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))
                                : !request
                                    ? Text("Request",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ))
                                    : Text(
                                        "Requested",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic),
                                      ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Message",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                child: Text('Skills'),
                alignment: Alignment.center,
              ),
              Wrap(
                spacing: 0,
                runSpacing: 0,
                children: curvisiteduser.skills
                    .map((e) => GridItem(interest: e))
                    .toList(),
              ),
              Container(
                height: 20,
                width: double.infinity,
                child: Text('Interests'),
                alignment: Alignment.center,
              ),
              Wrap(
                spacing: 0,
                runSpacing: 0,
                children: curvisiteduser.interst
                    .map((e) => GridItem(interest: e))
                    .toList(),
              ),
              Container(
                height: 20,
                width: double.infinity,
                child: Text('Group Joined'),
                alignment: Alignment.center,
              ),
            ],
          ),
        ));
  }
}
