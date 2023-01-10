import 'package:flutter/material.dart';

class DummyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 50),
      ),
    ));
  }

  // _DummyHomePageState createState() => _DummyHomePageState();
}

// class _DummyHomePageState extends State<DummyHomePage> {
//   int _selectedIndex = 0;

//   void _navigateBottomBar(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }