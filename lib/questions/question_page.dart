// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_6/pages/forgot_pw_page.dart';
import 'package:flutter_login_6/questions/quest_category.dart';
import 'package:flutter_login_6/widget/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//why is the class, whatever's beside the const and the state all called the same name?
//what is super?? what is super.dispose();
//how does clicking signUp function redirect you to homePage - je suis confused!!

final userRef = FirebaseFirestore.instance.collection('users');
// final userRef =
//     FirebaseFirestore.instance.useFirestoreEmulator('192.168.7.24', 8080);

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with AutomaticKeepAliveClientMixin<QuestionPage> {
  String name1 = 'Anna';
  String name2 = 'Bernd';
  String name3 = 'Christina';
  String name4 = 'David';
  String name5 = 'Elena';
  // var namesList = new List<String>();
  List<String> namesList = [
    'note1.wav',
    'note2.wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];
  // List<RaisedButton> buttonsList = new List<RaisedButton>();
  List<MaterialButton> buttonsList = [];
  List<String> docIDs = [];
  List<String> questionCategories = [];
  String collection = 'users';
  var collectionList;

  final _fireStore = FirebaseFirestore.instance;
  Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot membersData = await _fireStore.collection('users2').get();
    QuerySnapshot querySnapshot = await _fireStore.collection('users').get();

    // Get data from docs and convert map to List
    // final membersList = membersData.docs.map((doc) => doc.data()).toList();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    // final allData =
    //         querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();

    print(allData);
  }

  Future questionPageInit() async {
    print("supposed to initialize page here");
    for (int i = 0; i < questionCategories.length; i++) {
      print(questionCategories[i]);
    }
    //return CategoryPage(categoryName: "Philosophy");
  }

  @override
// Future categoryAdd() async {

// }

  // void initState() {
  //   // namesList.add(name1);
  //   // namesList.add(name2);
  //   // namesList.add(name3);
  //   // namesList.add(name4);
  //   // namesList.add(name5);
  //   // getUsers().then((result) {
  //   //   // print("result: $result");
  //   //   // for (int i = 0; i < questionCategories.length; i++) {
  //   //   //   buttonsList.add(new MaterialButton(
  //   //   //       onPressed: () {}, child: Text(questionCategories[i])));
  //   //   // }
  //   //   //print(questionCategories[0]);
  //   //   setState(() {});
  //   // });
  //   super.initState();
  //   setState(() {});
  //   // for (int i = 0; i < questionCategories.length; i++) {
  //   //   print(questionCategories[i]);
  //   // }
  //   //print(questionCategories[0]);
  // }

  Future getCategories() async {
    // userRef.get().then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((DocumentSnapshot doc) {
    //     print(doc.data);
    //   });
    // });

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (document) {
                //print(document.reference);
                //print(document.id);
                //docIDs.add(document.reference.id);
                questionCategories.add(document.reference.id);
                //print(document.reference.id);
                //print(document.data());
              },
            ));

    collectionList =
        await FirebaseFirestore.instance.collection('users').doc("ALL").get();
    // .then((snapshot) => snapshot.docs.forEach(
    //       (collection) {
    //         //print(document.reference);
    //         //print(document.id);
    //         //docIDs.add(document.reference.id);
    //         questionCategories.add(collection.reference.id);
    //         //print(document.reference.id);
    //         //print(document.data());
    //       },
    //     )
    //     );

    await FirebaseFirestore.instance
        .collection('members')
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (document) {
                //print(document.reference);
                //print(document.id);
                //docIDs.add(document.reference.id);
                //print(document.reference.id);
                print(document.data()['email']);
              },
            ));

    //print(questionCategories[0]);

    // FirebaseFirestore.instance.collection("users").get().then((value) {
    //   value.docs.forEach((result) {
    //     FirebaseFirestore.instance
    //         .collection("users")
    //         .doc("Jokes2")
    //         .collection("Jokes")
    //         .get()
    //         .then((subcol) {
    //       //subcol.getDocuments();
    //       questionCategories.add(subcol.docs.toString());
    //       print(subcol.docs.toString());
    //       subcol.docs.forEach((element) {
    //         int index = 3;
    //         print(element.data()['${index}']);
    //       });
    //     });
    //   });
    // }
    //);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: "Pick a category",
          backgroundColor: (Colors.deepPurple[200])!,
          backArrowDisplay: false,
        ),

        //scaffold is your empty page
        backgroundColor: Colors.black,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FutureBuilder(
            future: getCategories(),
            builder: (context, snapshot) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: questionCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: //questionPageInit,
                              () {
                            print(collectionList);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              //return ForgotPasswordPage();
                              return CategoryPage(
                                categoryName: questionCategories[index],
                              );
                            }));
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: Text(questionCategories[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ))))),
                    );
                  },
                ),
              );
            },
          ),

          // GestureDetector(
          //     onTap: questionPageInit,
          //     // () {
          //     //   Navigator.push(context,
          //     //       MaterialPageRoute(builder: (context) {
          //     //     //return ForgotPasswordPage();
          //     //     return CategoryPage(
          //     //       categoryName: "Philo",
          //     //     );
          //     //   }));
          //     // },
          //     child: Container(
          //         padding: EdgeInsets.all(20),
          //         decoration: BoxDecoration(
          //           color: Colors.deepPurple,
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: Center(
          //             child: Text('Philosophy',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 18,
          //                 ))))),
          Center(
            child: Column(children: buttonsList),
          ),
          // Padding(padding: EdgeInsets.all(20),
          // child: buttonsList,)
        ])));
  }
}
