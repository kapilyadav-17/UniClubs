import 'package:flutter/material.dart';
import 'package:mentors/screens/tabs.dart';
import 'package:mentors/screens/people.dart';
import '../modal/user.dart';
import '../widgets/groupitem.dart';
import '../modal/dummydata.dart';
import '../modal/groupdata.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    Provider.of<DummyData>(context, listen: false).fetchtotalusers();
    Provider.of<GroupData>(context, listen: false).fetchGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grp = Provider.of<GroupData>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(People.routeName);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(),
                  color: Colors.blue.shade50,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Search People"),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text("Explore Groups"),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1),
                itemBuilder: (ctx, index) => GroupItem(
                  groupname: grp.groups[index].name,
                  memberscount: grp.groups[index].membersid.length +
                      grp.groups[index].admins.length,
                ),
                padding: EdgeInsets.all(20),
                //saddRepaintBoundaries: true,
                itemCount: grp.groups.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
