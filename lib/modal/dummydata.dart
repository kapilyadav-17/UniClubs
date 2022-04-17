import 'dart:developer';

import 'package:flutter/material.dart';
import './user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DummyData with ChangeNotifier {
  List<User> _users = [];

  Future<void> registeruser(
      String email, String password, String name, String major) async {
    /*var url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users.json');
    List<dynamic> newusernoskills = [];
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': email,
            'password': password,
            'name': name,
            'major': major,
            "skills": newusernoskills, //why this is not added ?
          }));
      _users.add(User(
          dbid: json.decode(response.body)['name'],
          id: email,
          password: password)); //AUTOMATICALLY INSIDE .then BLOCK
      _users.firstWhere((user) => user.id == email).name = name;
      _users.firstWhere((user) => user.id == email).major = major;
    } catch (error) {
      rethrow;
    }
    //name ,major,img=empty??
    //notifyListeners();*/
  }

  void remuser(String email) {
    _users.removeWhere((user) => user.id == email);
  }

//  ADD SOME METHODS IN USER CLASS WHICH ARE INVOKED FOR SINGLE USER e.g. update
  var lid;
  void currentUser(String id) {
    this.lid = id;
  }

  List<Posts> totalposts = []; //total posts
  //ADDING ONLY IN TOTAL POSTS
  Future<void> addPost(Posts p) async {
    //post details
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/posts.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'crid': p.crid,
            'text': p.txt,
            'iurl': p.img,
            'crname': p.crname,
            'postid': p.postid,
          }));
      totalposts.insert(
          0, Posts(crid: p.crid, crname: p.crname, postid: p.postid));
      totalposts[0].txt = p.txt;
      totalposts[0].img = p.img;
      for (int i = 0; i < _users.length; i++) {
        if (_users[i].id != p.crid) {
          _users[i].feed.insert(0, totalposts[0]); //adding to feed of others
        } else {
          //creator of post
          _users[i].mypost.insert(0, totalposts[0]); //adding to my post
        }
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchtotalposts() async {
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/posts.json');
    List<Posts> dummytotalpost = [];
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, p) {
        dummytotalpost.add(Posts(
            crid: p['crid'],
            crname: p['crname'],
            img: p['iurl'],
            txt: p['text'],
            postid: p['postid']));
      });
      totalposts = dummytotalpost;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchtotalusers() async {
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users.json');
    List<User> dummytotalusers = [];
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, u) {
        if (u.containsKey('skills')) {
          if (u.containsKey('activity')) {
            if (u.containsKey('con')) {
              dummytotalusers.add(
                User(
                  dbid: key,
                  id: u['id'],
                  password: u['password'],
                  major: u['major'],
                  name: u['name'],
                  skills: u['skills'],
                  activity: u['activity'],
                  con: u['con'],
                ),
              );
            }
            dummytotalusers.add(
              User(
                  dbid: key,
                  id: u['id'],
                  password: u['password'],
                  major: u['major'],
                  name: u['name'],
                  skills: u['skills'],
                  activity: u['activity']),
            );
          }

          dummytotalusers.add(User(
              dbid: key,
              id: u['id'],
              password: u['password'],
              major: u['major'],
              name: u['name'],
              skills: u['skills'])); //CONNECTIONS........
        } else {
          dummytotalusers.add(User(
              dbid: key,
              id: u['id'],
              password: u['password'],
              major: u['major'],
              name: u['name']));
        }
      });
      _users = dummytotalusers;
      //print(_users);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

//need to change this//call userslist here should not fetch first
  bool ath(String email, String password) {
    User us;
    if (_users.any((user) => user.id == email)) {
      us = _users.firstWhere((user) => user.id == email);
      if (us.password == password) {
        //print("matched");
        return true; //o.k.
      }
      return false; //incorrect password
    }
    return false; //invalid email
  }

  Future<int> authenticate(String email, String password) async {
    //fetching a user and matching email and password
    //errors based on this email dne from server//dne match from application
    User us;
    //FIRST WE NEED WHOLE LIST BUT WE DONT NEED IT FOR SINGLE USER // NEED IT JUST ON TIME
    List<User> dummytotalusers = [];
    try {
      print("start");
      final url = Uri.parse(
          'https://mentors-253e7-default-rtdb.firebaseio.com/users.json');
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      print("got response");

      data.forEach((key, u) {
        dummytotalusers.add(User(
            dbid: key,
            id: u['id'],
            password: u['password'],
            major: u['major'],
            name: u['name']));
      });
      print("fetched data");
      if (dummytotalusers.any((user) => user.id == email)) {
        us = dummytotalusers.firstWhere((user) => user.id == email);
        if (us.password == password) {
          print("matched");
          return Future.value(1); //o.k.
        }
        return Future.value(0); //incorrect password
      }
      return Future.value(-1); //invalid email
    } catch (error) {
      rethrow;
    }

    //u=_users.firstWhere((user) => user.id == email, orElse :()=> -0);
  }

  Future<void> updateUser(String id, String name, String major) async {
    User u = _users.firstWhere((element) => element.id == id);
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u.dbid}.json');
    try {
      final response = await http.patch(url,
          body: json.encode({'name': name, 'major': major}));
      _users.firstWhere((user) => user.id == id).name = name;
      _users.firstWhere((user) => user.id == id).major = major;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addSkill(List<dynamic> newskills, String id) async {
    User u = _users.firstWhere((element) => element.id == id);

    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u.dbid}.json');
    try {
      final response =
          await http.patch(url, body: json.encode({"skills": newskills}));
      u.skills = newskills;
    } catch (error) {
      rethrow;
    }
  }

  List<dynamic> getconn(String id) {
    // no need to declare this method
    //id of logged in user
    return _users.firstWhere((user) => user.id == id).con;
  }

  //DISJOINT SET OR GRAPH TO CHECK CONNECTION???
  bool isconnected(String id1, String id2) {
    //print(_users.firstWhere((user) => user.id == id1).con.contains(id2));
    return _users.firstWhere((user) => user.id == id1).con.contains(id2);
  }

  User get data {
    //return [..._users];
    return _users[lid];
  }

  User get loggedin {
    //eliminated the need to pass id
    return _users
        .firstWhere((user) => user.id == lid); //lid int is compared to string
  }

  Future<void> addreqactivity(String id1, String id2) async {
    User u = _users.firstWhere((element) => element.id == id1);
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u.dbid}.json');
    List<dynamic> activities = u.activity;
    activities.add(id2);
    try {
      final response =
          await http.patch(url, body: json.encode({'activity': activities}));
    } catch (error) {
      rethrow;
    }
  }

  List<dynamic> getreqactivity(String id) {
    //no need
    //but with each activity all the list will be rebuild
    return _users.firstWhere((user) => user.id == id).activity;
  }

  Future<void> remreqactivity(String id1, String id2) async {
    User u = _users.firstWhere((element) => element.id == id1);
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u.dbid}.json');
    List<dynamic> activities = u.activity;
    activities.remove(id2);
    try {
      final response =
          await http.patch(url, body: json.encode({'activity': activities}));
    } catch (error) {
      rethrow;
    }
  }

//make single update method,change provided fields and others as it is
  Future<void> addcon(String id1, String id2) async {
    User u = _users.firstWhere((element) => element.id == id1);
    final url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u.dbid}.json');
    List<dynamic> con = u.con;
    con.add(id2);
    try {
      final response = await http.patch(url, body: json.encode({'con': con}));
      _users.firstWhere((user) => user.id == id1).con.add(id2);
      User u1 = _users.firstWhere((element) => element.id == id2);
      final url1 = Uri.parse(
          'https://mentors-253e7-default-rtdb.firebaseio.com/users/${u1.dbid}.json');
      List<dynamic> con1 = u.con;
      con1.add(id2);
      final response1 =
          await http.patch(url1, body: json.encode({'con': con1}));
      _users.firstWhere((user) => user.id == id2).con.add(id1);
    } catch (error) {
      rethrow;
    }
  }

  void remcon(String id1, String id2) {
    _users.firstWhere((user) => user.id == id1).con.remove(id2);
    _users.firstWhere((user) => user.id == id2).con.remove(id1);
  }

  void addreq(String id) {}
  void remreq(String id) {}
  void addimg(String img) {}
  //Future<void> fetchdata(){}
  User getbyid(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  List<User> searchPeople(String searched) {
    return _users
        .where((user) =>
            user.name.toLowerCase().contains(searched.toLowerCase().trim()))
        .toList(); //remove white space
  }

  List<User> searchSkills(String searched) {
    for (var i = 0; i < _users.length; i++) {
      for (var element in _users[i].skills) {
        element = element.toLowerCase();
      }
    }
    return _users.where((user) => user.skills.contains(searched)).toList();

    //but not able to convert each skill to lower case
  } //search in both skill and interest and on search results listtile highlight if this is skill or interest

  List<User> searchInterest(String searched) {
    for (var i = 0; i < _users.length; i++) {
      for (var element in _users[i].interst) {
        element = element.toLowerCase();
      }
    }
    return _users.where((user) => user.interst.contains(searched)).toList();
  }
  //major
}
/*
id: '1',
        name: 'Kapil',
        skills: ['C/C++', 'Python', 'Sql', 'hkjkjh', 'khkjhk', 'hkjkjhkj'],
        interst: [
          'flutter',
          'Ai',
          'jlkjlljl',
          'hkkkkkkkk',
          'jhhhhhhhk',
          'jhhhk',
          'jhhhhhh',
          'nbbbbbb',
          'jkkk',
          'hj',
          'hlkj',
          'hhhhhhh',
          'kkkkkkk',
          'jjjjj'
        ],
        major: 'CSE'),
    User(
        id: '2',
        name: 'Unknown',
        skills: ['C/C++', 'R', 'Sql'],
        interst: ['Bridge', 'Ai'],
        major: 'CIVIL'),
    User(
        id: '3',
        name: 'Ayush',
        skills: ['C/C++', 'Java', 'Go'],
        interst: ['Wiring', 'Switch'],
        major: 'ELECTRICAL'),
    User(
        id: '4',
        name: 'Shubham',
        skills: ['C/C++', 'Robot', 'Sql'],
        interst: ['Kinematics', 'Cycle'],
        major: 'MECH'),
    User(
        id: '5',
        name: 'Atul',
        skills: ['C/C++', 'Kotlin', 'Sql'],
        interst: ['App', 'Hacking'],
        major: 'CSE'),
*/
