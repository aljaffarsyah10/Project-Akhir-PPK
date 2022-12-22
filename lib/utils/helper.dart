import 'package:flutter/material.dart';

void nextScreen(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

class Helper {
  static nextScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
    );
  }
}
