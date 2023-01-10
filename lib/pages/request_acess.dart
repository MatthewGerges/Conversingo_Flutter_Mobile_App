import 'package:flutter/material.dart';
import 'package:flutter_login_6/widget/custom_appbar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestAccessPage extends StatefulWidget {
  const RequestAccessPage({Key? key}) : super(key: key);

  @override
  State<RequestAccessPage> createState() => _RequestAccessPage();
}

class _RequestAccessPage extends State<RequestAccessPage> {
  List<String> existingQuestionCategories = [];
  final _usernameController = TextEditingController();
  final _questionController = TextEditingController();
  final _passwordController = TextEditingController();
  final CollectionReference<Map<String, dynamic>> questionCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Request Access To Questions",
          backgroundColor: (Colors.deepPurple[200])!,
          backArrowDisplay: false,
        ),
        backgroundColor: Color.fromRGBO(36, 37, 38, 1),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              //category name textfield
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username / Email',
                        // hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              //password textfield
              SizedBox(height: 40),
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

              SizedBox(height: 250),

              //Sign in Button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                      //onTap: submitQuestion,
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text('Send Request',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )))))),
              SizedBox(height: 25),
              //Not a member? Register Now
            ])))));
  }
}
