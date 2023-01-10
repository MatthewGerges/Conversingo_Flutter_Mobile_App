import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_6/pages/nav_page.dart';
import 'package:flutter_login_6/questions/question_page.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import 'auth_page.dart';

//what's a stateless widget and what's the other type?
//what's a stream builder? What's a stream
//what does line 8: key key do?
//what's a scaffold?

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      //auth state change occurs when we click sign in button
      //snapshot gives us info of user
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //return HomePage();
          // return QuestionPage();
          return NavigationPage();
        } else {
          //return LoginPage();
          //idk why the above returns an error? - because it takes in a parameter of showRegisterPage (required) but you're not passing it in
          return AuthPage();
        }
      },
    ));
  }
}
