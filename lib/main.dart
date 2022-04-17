import 'package:flutter/material.dart';
import 'package:mentors/screens/creategroup.dart';
import 'package:mentors/screens/otppage.dart';
import 'package:mentors/services/shared_service.dart';
import '../screens/login.dart';
import '../screens/home.dart';
import '../screens/signup.dart';
import './screens/tabs.dart';
import 'package:provider/provider.dart';
import '../modal/dummydata.dart';
import '../modal/groupdata.dart';
import './screens/visited.dart';
import '../screens/activity.dart';
import '../screens/people.dart';
import '../screens/conn.dart';
import '../screens/editprofile.dart';
import '../screens/editprofile.dart';
import '../screens/createprofile.dart';
import '../screens/addskills.dart';
import '../screens/grouplanding.dart';
import '../screens/addpost.dart';
import './screens/fake.dart';
//import 'package:splashscreen/splashscreen.dart';

Widget defaulthome = Login();

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  bool result = await SharedService.tryautologin();
  //logic of isauth 
  if (result) {
    defaulthome = Fake();
  }*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DummyData(),
          ),
          ChangeNotifierProvider(
            create: (context) => GroupData(),
          ),
          ChangeNotifierProvider(
            create: (context) => SharedService(),
          )
        ],
        child: Consumer<SharedService>(
          builder: (ctx, shared, _) => MaterialApp(
            //theme: theme,
            color: Colors.white,

            title: 'RInsta',
            //initialRoute: '/',

            home: FutureBuilder(
              future: shared.tryautologin(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : snapshot.data == false
                          ? Login()
                          : Fake(),
            ),
            routes: {
              TabsState.routeName: (ctx) => Tabs(),
              //'/': (ctx) => Login(),
              Login.routeName: (ctx) => Login(),
              Home.routeName: (ctx) => Home(),
              SignupState.routeName: (ctx) => Signup(),
              Visited.routeName: (ctx) => Visited(),
              Activity.routeName: (ctx) => Activity(),
              People.routeName: (ctx) => People(),
              Connected.routeName: (ctx) => Connected(),
              EditProfile.routeName: (ctx) => EditProfile(),
              CreateProfile.routeName: (ctx) => CreateProfile(),
              CreateGroup.routeName: (ctx) => CreateGroup(),
              GroupLanding.routeName: (ctx) => GroupLanding(),
              Post.routeName: (ctx) => Post(),
              AddSkill.routeName: (ctx) => AddSkill(),
              Otp.routeName: (ctx) => Otp(),
              Fake.routeName: (ctx) => Fake(),
            },
          ),
        ));
  }
}
/*
class SpScreen extends StatelessWidget {
  const SpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.white,
      seconds: 3,
      navigateAfterSeconds: Login(),
      image: const Image(image: AssetImage('lib/assests/image/logo22.png')),
      title: Text("RInsta"),
      photoSize: 150,
    );
  }
}
*/
