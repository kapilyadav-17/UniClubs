import 'package:flutter/material.dart';
import '../modal/dummydata.dart';
import 'package:provider/provider.dart';
import '../screens/visited.dart';

class EachResult extends StatefulWidget {
  //const ListItem({ Key? key }) : super(key: key);
  final String id;
  EachResult(this.id);

  @override
  State<EachResult> createState() => EachResultState();
}

class EachResultState extends State<EachResult> {
  @override
  Widget build(BuildContext context) {
    final cur = Provider.of<DummyData>(context);
    final curuser = cur.getbyid(widget.id);
    final loggedinuser = cur.loggedin;
    return ListTile(
      leading: CircleAvatar(
        child: Text('KY'),
        backgroundColor: Colors.green,
        radius: 20,
      ),
      title: Text(curuser.name),
      onTap: () {
        Navigator.of(context).pushNamed(Visited.routeName, arguments: {
          "id1": loggedinuser.id,
          "id2": widget.id,
        }); //passing id by constructor or invoking a function
      },
      horizontalTitleGap: 30,
      subtitle: Text(curuser.major),
    );
  }
}
