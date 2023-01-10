import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName extends StatelessWidget {
  final String documentID;
  //difference between final string and string?
  GetUserName({required this.documentID});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //map string to dynamic basically maps whatever you had in get user details where you're making email equal to a string email and an age equal to an int

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        //future means you're waiting for something before executing
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['first name']}' +
                ' ' +
                '${data['last name']},' +
                ' ' +
                '${data['age']}' +
                ' years old');
          }
          return Text('loading...');
        }));
  }
}
