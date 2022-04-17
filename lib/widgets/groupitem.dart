import 'package:flutter/material.dart';
import '../screens/grouplanding.dart';

class GroupItem extends StatefulWidget {
  //const GroupItem({Key? key}) : super(key: key);
  final groupname;
  final memberscount;
  GroupItem({required this.groupname, required this.memberscount});
  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.pink,
            child: Text('KY'),
            radius: 30,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.groupname)],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("${widget.memberscount}"), Text("members")],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(GroupLanding.routeName);
                },
                child: Text("Join")),
          ),
        ],
      ),
    );
  }
}
