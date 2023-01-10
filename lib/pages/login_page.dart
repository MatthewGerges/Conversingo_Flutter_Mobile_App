// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_login_6/pages/nav_page.dart';
import 'package:flutter_login_6/questions/question_page.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_pw_page.dart';

//why do we even need to pass in the showRegisterPage widget - why can't it be something we import?
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//what is final??
//why do we have to do widget.showregisterpage? instead of this.registerPage
//when do you add children to a widget - always? What counts as a widget?

class _LoginPageState extends State<LoginPage> {
//text controllers - gives you access to what user typed
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  //disposing of the emails and passwords when not in use helps with memory management
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //scaffold is your empty page
        backgroundColor: Color.fromRGBO(36, 37, 38, 1),
        // body: SafeArea(
        // child: Center(
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Icon(Icons.local_fire_department, size: 120, color: Colors.red),
              SizedBox(height: 55),

              //Hello Again!
              Text('Conversingo',
                  style: TextStyle(
                      fontSize: 52, color: Color.fromRGBO(255, 255, 242, 1))
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 36,
                  // ),
                  ),
              Text(
                "Welcome to Matthew's Mind!",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(255, 255, 242, 1)),
              ),
              SizedBox(height: 50),

              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Email'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ForgotPasswordPage();
                      //return QuestionPage();
                      //return NavigationPage();
                    }));
                  },
                  child: Text('Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ))),
              SizedBox(height: 10),
              //Sign in Button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text('Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )))))),
              SizedBox(height: 25),
              //Not a member? Register Now
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Not a member?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: Text(' Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ])
            ]))));
  }

//what is extneds? what is a class -based widget bs state widget or are they completely different things
//what is @override
//what does createState do?
}
