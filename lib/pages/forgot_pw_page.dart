import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Alert(
        context: context,
        title: "Success!",
        desc: "Password reset link sent! Check your email",
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => {Navigator.pop(context)},
            width: 120,
          )
        ],
      ).show();
    } on FirebaseAuthException catch (e) {
      print(e);
      Alert(context: context, title: "Error", desc: e.message.toString())
          .show();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          elevation: 0,
        ),
        backgroundColor: Color.fromRGBO(36, 37, 38, 1),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
                'Enter Your Email and we will send you a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(255, 255, 242, 1))),
          ),
          //email textfield
          SizedBox(height: 10),
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
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () => {passwordReset()},
            child: Text('Reset Password'),
            color: Colors.deepPurple[200],
          )
        ]));
  }
}
