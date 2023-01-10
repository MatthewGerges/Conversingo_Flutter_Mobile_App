import 'package:flutter/material.dart';
import 'package:flutter_login_6/widget/custom_appbar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DummySubmitPage extends StatefulWidget {
  const DummySubmitPage({Key? key}) : super(key: key);

  @override
  State<DummySubmitPage> createState() => _DummySubmitPage();
}

class _DummySubmitPage extends State<DummySubmitPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DummySubmitPage> {
  late AnimationController _animationController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //         title: "Submit Your Question",
  //         backgroundColor: (Colors.deepPurpleAccent[200])!),
  //     body: Center(
  //       child: Text(
  //         'Submit Page',
  //         style: TextStyle(fontSize: 50),
  //       ),
  //     ),
  //   );
  // }
  List<String> existingQuestionCategories = [];
  final _categoryController = TextEditingController();
  final _questionController = TextEditingController();
  final _passwordController = TextEditingController();
  final CollectionReference<Map<String, dynamic>> questionCollection =
      FirebaseFirestore.instance.collection('users');

  Future submitQuestion() async {
    String categoryAsString = _categoryController.text.trim();
    String questionAsString = _questionController.text.trim();
    if (int.parse(_passwordController.text.trim()) == 4004) {
      print("nice");
      //add user details
      addQuestion(
        categoryAsString,
        questionAsString,
      );
    } else {
      Alert(
        context: context,
        title: "Incorrect Password!",
        desc: "Question was not submit!",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => {Navigator.pop(context)},
            width: 120,
          )
        ],
      ).show();
      // } on Fire catch (e) {
      //   print(e);
      //   Alert(context: context, title: "Error", desc: e.message.toString())
      //       .show();
      // }
    }

    // await FirebaseFirestore.instance
    // .collection('users')
    // .get()
    // .then((snapshot) => snapshot.docs.forEach(
    //       (document) {
    //         //print(document.reference);
    //         //print(document.id);
    //         //docIDs.add(document.reference.id);
    //         existingQuestionCategories.add(document.reference.id);
    //         print(document.reference.id);
    //         //print(document.reference.id);
    //         //print(document.data());
    //       },
    //     ));
  }

  Future getWhatExists() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (document) {
                //print(document.reference);
                //print(document.id);
                //docIDs.add(document.reference.id);
                existingQuestionCategories.add(document.reference.id);
                print(document.reference.id);
                //print(document.reference.id);
                //print(document.data());
              },
            ));
  }

  Future addQuestion(String category, String question) async {
    var usersRef = questionCollection.doc(category);

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach(
              (document) {
                existingQuestionCategories.add(document.reference.id);
              },
            ));

    if (existingQuestionCategories.contains(category)) {
      print("Document Exists! ");
      questionCollection.doc(category).update({question: question});
    } else {
      // FieldPath pathfield = FieldPath.fromString(category);
      //String category2 = pathfield.category;
      print('No such document exists so now about to set document anew!');
      print(category);
      FirebaseFirestore.instance
          .collection("users")
          .doc(category)
          .set({question: question});
    }
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _questionController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double scale1 = 1 + _animationController.value;

    return Scaffold(
        appBar: CustomAppBar(
          title: "Add New Question",
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
              SizedBox(height: 40),

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
                      controller: _categoryController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Category',
                        // hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              //question textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _questionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Question'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),

              //Sign in Button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                      onTap: submitQuestion,
                      onTapUp: onTapUp,
                      onTapDown: onTapDown,
                      onTapCancel: onTapCancel,
                      child: Transform.scale(
                        scale: scale1,
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text('Submit Question',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )))),
                      ))),
              SizedBox(height: 25),
              //Not a member? Register Now
            ])))));
  }

  onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  onTapCancel() {
    _animationController.reverse();
  }
}
