import 'package:autentikasi/pages/album.dart';
import 'package:autentikasi/pages/daftar_obat.dart';
import 'package:autentikasi/pages/home_page.dart';
import 'package:autentikasi/pages/list_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/products.dart';
import 'daftar_pasien.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SideNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);

    return Drawer(
      backgroundColor: Colors.amber[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Okta Gilang Al Jaffarsyah',
              style: TextStyle(color: Colors.grey[200]),
            ),
            accountEmail: Text(
              'Aljaffarsyah10@gmail.com',
              style: TextStyle(color: Colors.grey[200]),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/okta.jpeg",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            // ),
            // DrawerHeader(
            //   child: Text(
            //     'RSUD Kotapinang',
            //     style: TextStyle(
            //         color: Color.fromARGB(255, 71, 59, 26), fontSize: 25),
            //   ),
            decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/rsud.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Homepage'),
            onTap: () => Navigator.pushNamed(context, HomePage.route),
            // onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Update Profile'),
            onTap: () => Navigator.pushNamed(context, albumPage.route),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(FlutterIcons.tasklist_oct),
            title: Text('List Task'),
            onTap: () => Navigator.pushNamed(context, ListProductPage.route),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            // leading: Icon(Icons.border_color),
            leading: Icon(FlutterIcons.medical_bag_mco),
            title: Text('Medical Cabinet'),
            onTap: () => Navigator.pushNamed(context, DaftarObatView.route),
          ),
          ListTile(
            leading: Icon(FlutterIcons.person_add_mdi),
            title: Text('List Patient'),
            onTap: () => Navigator.pushNamed(context, DaftarPasienView.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Provider.of<Auth>(context, listen: false).logout(),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child:
                Icon(Icons.chevron_left, color: Colors.grey[600], size: 50.0),
          ),
        ],
      ),
    );
  }
}
