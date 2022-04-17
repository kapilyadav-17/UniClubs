import 'package:flutter/material.dart';
import 'package:mentors/screens/addskills.dart';
import '../modal/dummydata.dart';
import 'package:provider/provider.dart';
import '../widgets/griditem.dart';
import 'package:mentors/screens/tabs.dart';
import 'package:mentors/screens/conn.dart';
import 'package:mentors/screens/editprofile.dart';

class Me extends StatelessWidget {
  //const Me({Key? key}) : super(key: key);

  //var id =userid -1;
  //final currentuser = Provider.of<DummyData>(ctx!);write inside build

  //final userid = 0; //can be taken from login or signup screen
  // Me(this.userid);
  @override
  Widget build(BuildContext context) {
    final currentuser = Provider.of<DummyData>(context);
    final currentuserdata = currentuser.loggedin;
    Future<bool> onbackpressed() {
      Navigator.of(context).pushReplacementNamed(TabsState.routeName);
      return Future.value(true);
    }

    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Colors.white,
          elevation: 1,
          title: Text('Profile '),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProfile.routeName);
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: WillPopScope(
          onWillPop: onbackpressed,
          child: SingleChildScrollView(
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
                              child: Image(
                                image: AssetImage(
                                    "lib/assets/image/bgprofile.png"),
                                fit: BoxFit.cover,
                              ),
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
                            child: Text(currentuserdata.name),
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
                            Text(
                              currentuserdata.major,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.link_sharp),
                            SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    Connected.routeName,
                                    arguments: currentuserdata.id);
                              },
                              child: Text(
                                'Connections',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text('${currentuserdata.con.length}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    'Skills',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
                currentuserdata.skills.length == 0
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddSkill.routeName);
                        },
                        child: Text("Add your first Skill"))
                    : Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        children: currentuserdata.skills
                            .map((e) => GridItem(interest: e))
                            .toList(),
                      ),
                Container(
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    'Interests',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
                currentuserdata.interst.length == 0
                    ? TextButton(
                        onPressed: () {},
                        child: Text("Add your first Interest"))
                    : Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        children: currentuserdata.interst
                            .map((e) => GridItem(interest: e))
                            .toList(),
                      ),
                Container(
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    'Group Joined',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    'Posts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ));
  }
}

/*GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 15,mainAxisSpacing: 10,childAspectRatio: 1/2), 
    itemBuilder: (ctx,index)=> GridItem(interest: data.interest[index])
    ,padding: EdgeInsets.all(10),itemCount: data.interest.length,)  
*/
/*
    GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 15,mainAxisSpacing: 10,childAspectRatio: 1/2), 
    itemBuilder: (ctx,index)=> GridItem(interest: data.skills[index])
    ,padding: EdgeInsets.all(10),itemCount: data.skills.length,) ,
    )
    */
/*
GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 1),
                    itemBuilder: (ctx, index) =>
                        GridItem(interest: data[userid].interst[index]),
                    padding: EdgeInsets.all(20),
                    //saddRepaintBoundaries: true,
                    itemCount: data[userid].interst.length,
                  )

*/

/*
GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 1),
                  itemBuilder: (ctx, index) =>
                      GridItem(interest: data[userid].skills[index]),
                  padding: EdgeInsets.all(20),
                  //addRepaintBoundaries: true,
                  itemCount: data[userid].skills.length,
                ),
*/
/*
Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(),
                    color: Colors.indigo,
                  ),*/
                child: Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  children: data[userid]
                      .interst
                      .map((e) => GridItem(interest: e))
                      .toList(),
                ),
              )
*/