// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_6/widget/custom_appbar.dart';

//why is the class, whatever's beside the const and the state all called the same name?
//what is super?? what is super.dispose();
//how does clicking signUp function redirect you to homePage - je suis confused!!

class CategoryPage extends StatefulWidget {
  final String categoryName;
  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late AnimationController _animationController3;

  @override
  void initState() {
    super.initState();
    _animationController3 = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _animationController = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _animationController2 = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  Future CategoryPageInit() async {
    print("supposed to initialize page here");
  }

  int enteredFunction = 0;
  int enteredFunction2 = 0;

  List<String> questionsList = ["Start"];
  // List<int> numbers = [1000, 2, 3];
  // List<String> newQuestions = ["What's gucci", "I ate a frog"];

  int index = 0;

  bool nextQuestion() {
    if (index < questionsList.length - 1) {
      index++;
      setState(() {
        index = index;
      });
      for (int i = 0; i < questionsList.length; i++) {
        print(questionsList[i]);
      }
      print(questionsList.length);
      print(index);
      return true;
      // print(numbers.length);
      // newQuestions.add("new question here");
      // print("New questions is ${newQuestions.length} cool?");
    } else {
      print("At end of list");
      return false;
    }
  }

  bool previousQuestion() {
    if (index > 0) {
      index--;
      setState(() {
        index = index;
      });
      print(index);
      return true;
    } else {
      print("At beginning of list");
      return false;
    }
  }

  void shuffleQuestions() {
    questionsList.shuffle();
    setState(() {
      index = 0;
    });
    // if (!nextQuestion()) {
    //   previousQuestion();
    // }
  }

  void printQuestionList(snapshot) {
    if (enteredFunction > 0) {
      return;
    }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    int questionNumberWhat = 0;
    for (String key in data.keys) {
      print(key + data[key]!);
      questionsList.add(data[key]);
      // print("question number is ${questionNumberWhat}");
      // questionNumberWhat++;
      // print("question list is ye long: ${questionsList.length}");
    }
    enteredFunction++;
  }

  void printAllQuestionsList(snapshot) {
    // if (enteredFunction > 0) {
    //   return;
    // }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    int questionNumberWhat = 0;
    for (String key in data.keys) {
      print(key + data[key]!);
      questionsList.add(data[key]);
      // print("question number is ${questionNumberWhat}");
      // questionNumberWhat++;
      // print("question list is ye long: ${questionsList.length}");
    }
    //enteredFunction++;
  }

  int questIndex = 1;

  Future getQuestionList() async {
    if (questIndex > 1) {
      return;
    }
    if (widget.categoryName == "ALL") {
      // await FirebaseFirestore.instance.collection('users').get().then((val) {
      //   for (int i = 0; i < 30; i++) {
      //     print(val.docs[2].data());
      //     //printQuestionList(val.docs[i].data());
      //   }
      //   if (val.docs.length > 0) {
      //     //print(val.docs[i].data());
      //   }
      // });
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then(((snapshot) => snapshot.docs.forEach((document) {
                // print(document.reference);
                // docIDs.add(document.reference.id);
                print(document.reference.id);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(document.reference.id)
                    .get()
                    .then((snapshot) => {printAllQuestionsList(snapshot)});
                //printAllQuestionsList(document.reference.id);
              })));
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.categoryName)
          .get()
          .then((snapshot) => {printQuestionList(snapshot)});
    }
    //       subcol.docs.forEach((element) {
    //         int index = 3;
    //         print(element.data()['${index}']);
    //       }

    //     userRef.get().then((snapshot) => snapshot.docs.forEach(
    //   (document) {
    //     //print(document.reference);
    //     //print(document.id);
    //     //docIDs.add(document.reference.id);
    //     questionCategories.add(document.reference.id);
    //     //print(document.data());
    //   },
    // )
    questIndex++;
  }

  @override
  Widget build(BuildContext context) {
    double scale1 = 1 + _animationController.value;
    double scale2 = 1 + _animationController2.value;
    double scale3 = 1 + _animationController3.value;
    //double scale3 = 1.1;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.categoryName,
          backgroundColor: (Colors.deepPurple[200]!),
          backArrowDisplay: true,
        ),

        //scaffold is your empty page
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(height: 100),
            Padding(
                padding: const EdgeInsets.all(1.0),
                child: FutureBuilder(
                    future: getQuestionList(),
                    builder: ((context, snapshot) {
                      // return TextField(
                      //   decoration: InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         width: 5, //<-- SEE HERE
                      //         color: Colors.greenAccent,
                      //       ),
                      //       borderRadius: BorderRadius.circular(50.0),
                      //     ),
                      //   ),
                      // );f
                      return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(10.0),
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))
                              // border: Border.all(color: Colors.blueAccent)
                              ),
                          child: Align(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                questionsList[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ));
                    }))
                // Text(
                //   questionsList[index],
                //   style: TextStyle(
                //     //color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18,
                //   ),
                // ),
                ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTapUp: onTapUp3,
                    onTapDown: onTapDown3,
                    onTapCancel: onTapCancel3,
                    onTap: previousQuestion,
                    child: Transform.scale(
                      scale: scale3,
                      child: Icon(
                        Icons
                            .arrow_circle_left_outlined, // add custom icons also
                        size: 65,
                        color: Colors.white, // add custom icons also
                      ),
                    ),
                  ),
                ),
                Padding(
                  //margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  // decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  // border: Border.all(color: Colors.white)
                  // ),
                  child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: shuffleQuestions,
                        onTapUp: onTapUp2,
                        onTapDown: onTapDown2,
                        onTapCancel: onTapCancel2,
                        child: Transform.scale(
                          scale: scale2,
                          child: Icon(
                            Icons.shuffle_on_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      )
                      // Text(
                      //   "RANDOM",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 20,
                      //   ),
                      // textDirection: TextDirection.ltr,
                      // textAlign: TextAlign.center,
                      ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: nextQuestion,
                      onTapUp: onTapUp,
                      onTapDown: onTapDown,
                      onTapCancel: onTapCancel,
                      child: Transform.scale(
                        scale: scale1,
                        child: Icon(
                          Icons
                              .arrow_circle_right_outlined, // add custom icons also
                          size: 65,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ]),
        ))));
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

  onTapUp2(TapUpDetails details) {
    _animationController2.reverse();
  }

  onTapDown2(TapDownDetails details) {
    _animationController2.forward();
  }

  onTapCancel2() {
    _animationController2.reverse();
  }

  onTapUp3(TapUpDetails details) {
    _animationController3.reverse();
  }

  onTapDown3(TapDownDetails details) {
    _animationController3.forward();
  }

  onTapCancel3() {
    _animationController3.reverse();
  }
}
