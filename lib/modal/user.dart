class User {
  final String dbid;
  final String id;
  String name;
  String imageUrl = "";
  final String password;
  List<dynamic> skills;
  List<String> interst = [];
  //need to make non final and add with methods
  List<Posts> mypost = [];
  List<Posts> feed = [];
  String major;
  //int conn = 0;
  int req = 0;
  List<dynamic> activity;
  List<String> groupsjoined = [];
  List<dynamic> con =
      []; //contains id's of connected people//sbhi ke me ho gya//dont write here
  User(
      {required this.dbid,
      required this.id,
      required this.password,
      this.name = "",
      this.major = "",
      this.skills = const [],
      this.activity = const [],
      this.con = const []});
  //factory User.fromjson(Map{String ,dynamic} json){
  //return User(dbid: dbid, id: id, password: password)
  //}
}

class Posts {
  final String crid;
  final String postid;
  final String crname;
  //final String ttxt;
  //final DateTime dt = DateTime.now();
  String txt = "";
  String img = "";
  List<String> likedby = [];
  Posts(
      {required this.crid,
      required this.crname,
      this.txt = "",
      this.img =
          "https://tse2.mm.bing.net/th?id=OIP.avxhtQqr5FoubGjq4sIXugHaEo&pid=Api&P=0&w=265&h=166",
      required this.postid});
  // factory Post.fromjson(Map{String,dynamic} json){
  // return Post(postid: json, crid: crid,txt: ,img: :);
  //}
}

class Group {
  String imgurl = "";
  final String name;
  final groupid;
  //int members = 0;
  List<String> membersid = [];
  List<dynamic> admins = [];
  Group({required this.groupid, required this.name});
}
