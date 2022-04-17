import 'package:flutter/material.dart';
import 'package:mentors/screens/tabs.dart';

import 'package:mentors/widgets/eachresult.dart';
import '../modal/user.dart';
import '../modal/dummydata.dart';
import 'package:provider/provider.dart';
import '../widgets/eachresult.dart';

enum filters {
  people,
  skill,
  interest,
}

class People extends StatefulWidget {
  //const People({Key? key}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  static const routeName = "/SearchPeople";
  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  var selectedfilter = filters.people;
  List<User> results = [];
  var flag = 0;
  var searched; //to be taken from search field
  final mycontrol = TextEditingController();
  /*@override
  void initState() {
    super.initState();
    mycontrol.addListener(setsearch);
  }
   @override
  void dispose() {
    super.dispose();
    mycontrol.dispose();
  }
*/
  @override
  void initState() {
    //Provider.of<DummyData>(context, listen: false).fetchtotalusers();
    super.initState();
  } //SHOULD UPDATE WHEN SOME OTHER PERSON REGISTERS OR LEAVE

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final abc = Provider.of<DummyData>(context);
    void setresults(filters selfilter) {
      switch (selfilter) {
        case filters.people:
          results = abc.searchPeople(searched);
          flag = 1; //apply two string methods same time
          break;
        case filters.skill:
          results = abc.searchSkills(searched);
          flag = 1;
          break;
        case filters.interest:
          results = abc.searchInterest(searched);
          flag = 1;
          break;
        default:
        //print('jeu');
      }
    }

    Future<bool> onbackpressed() {
      Navigator.of(context).pushReplacementNamed(TabsState.routeName);
      return Future.value(true);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Search People'),
        //automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.brown,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('People'),
                value: filters.people,
              ),
              PopupMenuItem(
                child: Text('Skills'),
                value: filters.skill,
              ),
              PopupMenuItem(
                child: Text('Interest'),
                value: filters.interest,
              )
            ],
            //initialValue: filters.people,
            child: Container(
              child: Text(
                'Filters',
                style: TextStyle(fontSize: 20),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            onSelected: (filters selectedValue) {
              setState(() {
                if (selectedValue == filters.people) {
                  selectedfilter = filters.people;
                  setresults(
                      selectedfilter); //wrong should not be called on tapping filter should be called on searching
                }
                if (selectedValue == filters.skill) {
                  selectedfilter = filters.skill;
                  setresults(selectedfilter);
                }
                if (selectedValue == filters.interest) {
                  selectedfilter = filters.interest;
                  setresults(selectedfilter);
                }
              });
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: onbackpressed,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '  Search here',
                  icon: Icon(Icons.search),
                ),
                controller: mycontrol, //focus//it is rebuilding ok

                textInputAction: TextInputAction.search,
                onEditingComplete: () {
                  setState(() {
                    searched = mycontrol.text;
                    selectedfilter =
                        filters.people; //filter =skill//searching people
                  });
                  setresults(selectedfilter);
                  //how to change//Two taps???
                },
              ),
            ),
            flag == 1 && results.isEmpty
                ? Center(
                    child: Text(
                      "No Results Found",
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => Column(
                        children: [EachResult(results[i].id), const Divider()],
                      ),
                      itemCount: results.length,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
//filter t fun call mt kr
//selected filter show kr de...
//var chnge krde
//and seaerch  bahr t kr...keyboard
