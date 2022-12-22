import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:autentikasi/main.dart';
import '../providers/auth.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUserSignUp(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(data.name, data.password);
      } catch (err) {
        print(err);
        return err.toString();
      }
      return null;
    });
  }

  Future<String> _authUserLogin(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false)
            .login(data.name, data.password);
      } catch (err) {
        print(err);
        return err.toString();
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    // return Future.delayed(loginTime).then((_) async {
    //   try {
    //     await Provider.of<Auth>(context, listen: false).resetPassword();
    //   } catch (err) {
    //     print(err);
    //     return err.toString();
    //   }
    //   return null;
    // });
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'RSUD Labusel',
      // logo: 'assets/images/ecorp-lightblue.png',
      logo: 'assets/images/logo_labusel.jpg',
      onLogin: _authUserLogin,
      onSignup: _authUserSignUp,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          // label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(loginTime);
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          // label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.linkedinIn,
          callback: () async {
            debugPrint('start linkdin sign in');
            await Future.delayed(loginTime);
            debugPrint('stop linkdin sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.githubAlt,
          callback: () async {
            debugPrint('start github sign in');
            await Future.delayed(loginTime);
            debugPrint('stop github sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        Provider.of<Auth>(context, listen: false).tempData();
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
