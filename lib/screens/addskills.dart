import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({Key? key}) : super(key: key);
  static const routeName = '/AddSkillPage';
  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  final skillsearch = TextEditingController();
  //bool ischecked = false;
  List<dynamic> totalskills = [
    "Deep Learining",
    "Algorithms",
    "Coding",
    "Flutter",
    "Mobile App Development"
  ];
  //int skillscount = totalskills.length;
  List<dynamic> selectedboxes = [];
  List<bool> checked = List.filled(5, false);

  void addtototalskills() {}
  @override
  void initState() {
    final curuser = Provider.of<DummyData>(context, listen: false);
    final u1 = curuser.loggedin;
    final curuserskills = u1.skills;

    for (var element in curuserskills) {
      checked[totalskills.indexOf(element)] = true;
      //what if skill list is empty= loop will not execute=ok
      selectedboxes.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    final curuser = Provider.of<DummyData>(context);
    final u = curuser.loggedin;

    return Scaffold(
      appBar: AppBar(
        title: Text("Skills"),
        actions: [
          IconButton(
            onPressed: () {
              if (selectedboxes.isEmpty) {
                Navigator.of(context).pop();
              } else {
                curuser
                    .addSkill(selectedboxes, u.id)
                    .then((value) => Navigator.of(context).pop())
                    .catchError((onError) {});
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Search a skill.."),
            controller: skillsearch,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CheckboxListTile(
              value: checked[i],
              onChanged: (bool? newValue) {
                setState(() {
                  checked[i] = newValue!;
                });
                if (checked[i]) {
                  selectedboxes.add(totalskills[i]);
                } else {
                  selectedboxes.remove(totalskills[i]);
                }
              },
              title: Text(totalskills[i]),
            ),
            itemCount: totalskills.length,
          ))
        ],
      ),
    );
  }
}
//jo phle selected tha woh nhi dih rha because it is not tapped and it is not added to selectedboxes