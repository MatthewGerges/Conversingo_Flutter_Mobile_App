import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool backArrowDisplay;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.backArrowDisplay,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: backArrowDisplay,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        )
      ],
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(title),
      // actions: <Widget>[
      //   Padding(
      //       padding: EdgeInsets.only(right: 20.0),
      //       child: GestureDetector(
      //         onTap: () {
      //           // FirebaseAuth.instance.signOut();
      //           ForgotPasswordPage();
      //         },
      //         child: Icon(Icons.logout),
      //       )),
      // ],
    );
  }
}
