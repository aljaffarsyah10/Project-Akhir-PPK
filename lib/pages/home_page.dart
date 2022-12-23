import 'package:autentikasi/pages/album.dart';
import 'package:autentikasi/pages/dashboard.dart';
import 'package:autentikasi/pages/list_obat.dart';
import 'package:autentikasi/pages/list_product.dart';
import 'package:autentikasi/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autentikasi/utils/constants.dart';

import '../providers/products.dart';
import 'daftar_obat.dart';
import 'daftar_pasien.dart';

class HomePage extends StatefulWidget {
  static const route = "homepage";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentPageIndex = 0;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.scaffoldBackgroundColor,
        buttonBackgroundColor: Colors.amber,
        items: const <Widget>[
          Icon(
            FlutterIcons.ios_home_ion,
            size: 30.0,
            color: Colors.black87,
          ),
          Icon(
            // FlutterIcons.map_marker_radius_mco,
            FlutterIcons.tasklist_oct,
            size: 30.0,
            color: Colors.black87,
          ),
          Icon(
            // FlutterIcons.plus_ant,
            FlutterIcons.medical_bag_mco,
            size: 30.0,
            color: Colors.black87,
          ),
          Icon(
            FlutterIcons.person_add_mdi,
            size: 30.0,
            color: Colors.black87,
          ),
          Icon(
            FlutterIcons.setting_ant,
            size: 30.0,
            color: Colors.black87,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: [
          Dashboard(),
          ListProductPage(),
          DaftarObatView(),
          DaftarPasienView(),
          // ListObatPage(),
          // Container(
          //   color: Colors.blue,
          //   alignment: Alignment.center,
          //   child: const Text('Page 3'),
          // ),
          albumPage(),
          // ProfilePage(),
        ][currentPageIndex],
      ),
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.logout),
      //     onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
      //   ),
      //   title: Text("All Products"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () => Navigator.pushNamed(context, AddProductPage.route),
      //     ),
      //   ],
      // ),

      // body: ListProductPage(),

      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       icon: Icon(Icons.explore),
      //       label: 'Explore',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.commute),
      //       label: 'Commute',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.bookmark),
      //       icon: Icon(Icons.bookmark_border),
      //       label: 'Saved',
      //     ),
      //   ],
      // ),
    );
  }
}
