import 'package:autentikasi/pages/dashboard.dart';
import 'package:autentikasi/providers/Obat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';

import './providers/products.dart';
import './providers/auth.dart';

import './pages/home_page.dart';
import './pages/auth_page.dart';
import './pages/add_product_page.dart';
import './pages/edit_product_page.dart';
import 'pages/add_obat_page.dart';
import 'pages/edit_obat_page.dart';

// void main() async {
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const route = 'mainpage';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(),
          update: (context, auth, products) =>
              products..updateData(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, Obatan>(
          create: (context) => Obatan(),
          update: (context, auth, Obatan) =>
              Obatan..updateData(auth.token, auth.userId),
        ),
      ],
      builder: (context, child) => Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.orange,
            buttonColor: Colors.orange,
            textTheme: TextTheme(
              headline3: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 45.0,
                color: Colors.black,
              ),
              button: TextStyle(
                fontFamily: 'OpenSans',
              ),
              subtitle1: TextStyle(fontFamily: 'NotoSans'),
              bodyText2: TextStyle(fontFamily: 'NotoSans'),
            ),
          ),
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return LoginPage();
                  },
                ),
          initialRoute: MyApp.route,
          onGenerateRoute: _onGenerateRoute,
          routes: {
            AddProductPage.route: (ctx) => AddProductPage(),
            EditProductPage.route: (ctx) => EditProductPage(),
            AddObatPage.route: (ctx) => AddObatPage(),
            EditObatPage.route: (ctx) => EditObatPage(),
          },
        ),
      ),
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AddProductPage.route:
      return MaterialPageRoute(builder: (BuildContext context) {
        return AddProductPage();
      });
    case EditProductPage.route:
      return MaterialPageRoute(builder: (BuildContext context) {
        return EditProductPage();
      });
    // case Dashboard.route:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return Dashboard();
    //   });
    // case PageSwitch.route:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return PageSwitch();
    //   });

    // case "/search-results":
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return Notifications();
    //   });
    // case "/single-news":
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return SingleNewsPage();
    //   });
    // default:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return PageSwitch();
    //   });
  }
}
