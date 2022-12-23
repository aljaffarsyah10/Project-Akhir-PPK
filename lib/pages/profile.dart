import 'package:autentikasi/pages/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<StatefulWidget> {
  Widget _placeContainer(String title, Color color, bool leftIcon) {
    return FutureBuilder(
        // Initialize FlutterFire
        // future: Firebase.initializeApp(),
        builder: (context, snapshot) {
      // final user = FirebaseAuth.instance.currentUser;
      // print(user);
      // // if (user != null) {
      // // Name, email address, and profile photo URL
      // final name = user.displayName;
      // final email = user.email;
      // final photoUrl = user.photoURL;

      // // Check if user's email is verified
      // final emailVerified = user.emailVerified;

      // // The user's ID, unique to the Firebase project. Do NOT use this value to
      // // authenticate with your backend server, if you have one. Use
      // // User.getIdToken() instead.
      // final uid = user.uid;
      // }
      Column(
        children: <Widget>[
          Container(
              height: 60,
              // height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width - 40,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: color),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: leftIcon ? Color(0xffa3a3a3) : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  leftIcon
                      ? Icon(
                          Icons.add,
                          color: Color(0xffa3a3a3),
                        )
                      : Container()
                ],
              ))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideNavbar(),
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          // ),
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () =>
                  Provider.of<Auth>(context, listen: false).logout(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 242, 240, 231),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(40.0, 20, 40, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'My Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(10, 15),
                            color: Color(0x22000000),
                            blurRadius: 20.0)
                      ],
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'))),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Sonu Sharma',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70,
                ),
                _placeContainer('Evelens Apartment', Color(0xff526fff), false),
                _placeContainer('Parents House', Color(0xff8f48ff), false),
                _placeContainer('Add another one', Color(0xffffffff), true),
              ],
            ),
          ),
        ));
  }
}
