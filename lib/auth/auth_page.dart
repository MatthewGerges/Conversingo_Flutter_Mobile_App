import 'package:flutter/material.dart';
import 'package:flutter_login_6/pages/login_page.dart';
import 'package:flutter_login_6/pages/register_page.dart';

//where is authpage state used - and what's the point of making it stateful
//why are we passing in toggle screen - a function - as a widget??

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    //why does setState have the 2 curly brackets??
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // return LoginPage(showRegisterPage: showRegisterPage);
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      // return RegisterPage();
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
