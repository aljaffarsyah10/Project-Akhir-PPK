import 'package:autentikasi/pages/list_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/auth.dart';

import '../pages/add_product_page.dart';
import '../widgets/product_item.dart';
import 'SideNavbar.dart';

class HomePage extends StatefulWidget {
  static const route = "/list_product";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context, listen: false).inisialData().then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError(
        (err) {
          print(err);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error Occured"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Okay"),
                  ),
                ],
              );
            },
          );
        },
      );

      isInit = false;
    }
    super.didChangeDependencies();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_rounded),
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        ListProductPage(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Profile'),
        ),
      ][currentPageIndex],

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
