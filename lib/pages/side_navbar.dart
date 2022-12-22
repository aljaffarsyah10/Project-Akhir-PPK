import 'package:autentikasi/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/products.dart';

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
              'Oflutter.com',
              style: TextStyle(color: Colors.grey[200]),
            ),
            accountEmail: Text(
              'example@gmail.com',
              style: TextStyle(color: Colors.grey[200]),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
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
            title: Text('Welcome'),
            onTap: () => Navigator.pushNamed(context, HomePage.route),
            // onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => Navigator.of(context).pop(),
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
