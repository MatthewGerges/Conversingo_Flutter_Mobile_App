// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//why is the class, whatever's beside the const and the state all called the same name?
//what is super?? what is super.dispose();
//how does clicking signUp function redirect you to homePage - je suis confused!!

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _adminController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _adminController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //authenticate user
    if (passwordConfirmed()) {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //add user details
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        _adminController.text.trim(),
      );
    }
  }

  Future addUserDetails(String firstName, String lastName, String email,
      String accessCode) async {
    if (accessCode == "0069") {
      await FirebaseFirestore.instance.collection('admin').add({
        'first name': firstName,
        'last name': lastName,
        'email': email,
      });
    } else {
      await FirebaseFirestore.instance.collection('members').add({
        'first name': firstName,
        'last name': lastName,
        'email': email,
      });
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //scaffold is your empty page
        backgroundColor: Color.fromRGBO(36, 37, 38, 1),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              //Hello Again!
              Text('Hello There!',
                  style: TextStyle(
                      fontSize: 52, color: Color.fromRGBO(255, 255, 242, 1))
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 36,
                  // ),
                  ),
              // ignore: prefer_const_constructors
              Text(
                'Register your details below!',
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(255, 255, 242, 1)),
              ),
              SizedBox(height: 50),
//first name textfield
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
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'First Name'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              //last name textfield
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
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'last name'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

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
              //confirm password textfield
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
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //age textfield
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
                      controller: _adminController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Admin Access Code (Optional)'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Sign Up Button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )))))),
              SizedBox(height: 25),
              //Not a member? Register Now
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already a member?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 242, 1))),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(' Log In!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ])
            ])))));
  }
}
