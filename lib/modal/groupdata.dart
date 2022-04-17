import 'package:flutter/material.dart';
import './user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupData with ChangeNotifier {
  List<Group> groups = [];

  Future<void> addGroup(String name, String admin, String groupid) async {
    var url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/groups.json');
    List<dynamic> admins = [admin];

    try {
      final response = await http.post(url,
          body: json.encode(
              {"groupid": groupid, "groupname": name, "admins": admins}));
      //groups.add(Group(name: name, admin: adminid));
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchGroup() async {
    var url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/groups.json');
    List<Group> dummygroups = [];

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, u) {
        dummygroups.add(Group(
          groupid: key,
          name: u["groupname"],
        ));
        for (int i = 0; i < dummygroups.length; i++) {
          dummygroups[i].admins = u["admins"];
        }
      });
      groups = dummygroups;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addMember(String newmemid, String groupid) async {
    var url = Uri.parse(
        'https://mentors-253e7-default-rtdb.firebaseio.com/groups/${groupid}.json');
    groups.firstWhere((grp) => grp.groupid == groupid).membersid.add(newmemid);
    List<String> membersid =
        groups.firstWhere((grp) => grp.groupid == groupid).membersid;
    try {
      final response = await http.patch(url,
          body: json.encode({"membersid": membersid, "groupid": groupid}));
    } catch (error) {
      rethrow;
    }
  }
}
//CAN WE STORE LIST<STRING> IN FIREBASE
  

  /*Future<void> removeMember(String id) async{

  }*/

  //QUIZ
  //Post inside Group


//ui to create group is only for admin account