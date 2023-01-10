import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_6/read%20data/get_user_name.dart';

//what is @override
//diff between stateful and stateless widget?!?! what even is a widget?
//how do you know what to put inside each build component - ex. BuildContext context - and what is that?
//what is final? What's the exclamation mark for in flutter
//why is it below override

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //document IDs
  List<String> docIDs = [];

  //I think future means you wait for something to load?
  // get docIDs
  //other than descending tag, we have isGreatherThan: 55 and other tags
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('first name', descending: false)
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (document) {
                print(document.reference);
                docIDs.add(document.reference.id);
              },
            ));
  }

  // @override
  // void initState() {
  //   //TODO: implement initState
  //   getDocId();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(55.0),
            child: Text(
              user.email!,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          // actions: [
          //   GestureDetector(onTap: () {
          //     FirebaseAuth.instance.signOut();
          //   })
          // ],
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.menu, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Icon(Icons.logout),
                )),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //     //don't need to do a manual redirect callback to the page because signOut() does that for us
            //   },
            //   color: Colors.deepPurple[200],
            //   child: Text('sign out'),
            // ),
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GetUserName(documentID: docIDs[index]),
                          tileColor: Colors.grey[100],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )));
  }
}
