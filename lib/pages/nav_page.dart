import 'package:flutter/material.dart';
import 'package:flutter_login_6/pages/dummy_home.dart';
import 'package:flutter_login_6/pages/dummy_submit.dart';
import 'package:flutter_login_6/pages/request_acess.dart';
import 'package:flutter_login_6/questions/question_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin<NavigationPage> {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final List<Widget> _pages = [
  //   Center(
  //     child: Text(
  //       'HOME',
  //       style: TextStyle(fontSize: 50),
  //     ),
  //   ),
  //   Center(
  //     child: Text(
  //       'Quest Page',
  //       style: TextStyle(fontSize: 50),
  //     ),
  //   ),
  // ];
  final List<Widget> _pages = [
    QuestionPage(),
    //DummyHomePage(),
    DummySubmitPage(),
    //RequestAccessPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
              unselectedLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 14),
              unselectedItemColor: Colors.white,
              selectedItemColor: Color.fromRGBO(3, 37, 126, 1),
              backgroundColor: Colors.deepPurple[200],
              currentIndex: _selectedIndex,
              onTap: _navigateBottomBar,
              type: BottomNavigationBarType.fixed,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                  label: ('Submit'),
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.admin_panel_settings_outlined,
                //     size: 28,
                //     color: Colors.white,
                //   ),
                //   label: ('Access'),
                // ),
              ]),
        ));
  }
}
