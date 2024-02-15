import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/FirebaseAuth.dart';
import '../goalsScreen/update_goal.dart';

class GoalsScreenon extends StatelessWidget {
  const GoalsScreenon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _goalStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/goals/').snapshots();

    return Scaffold(appBar: AppBar(title: Text("Goals"),
    ),
    body: Column(children: [
      Flexible(
        child: Container(

          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: _goalStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Text("Loading");
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Goals"));
              }
              return Container(
                height: 150,
                child: ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                    DateTime date = DateTime.parse(
                        data['time'].toDate().toString());

                    return GestureDetector(
                        onLongPress: () => deletegoal(document.id),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateGoal(
                                  docid: document.id,
                                  previous: data["saved"]),
                            )),
                        child: Card(
                            color: Colors.orangeAccent,
                            margin: EdgeInsets.all(10),
                            elevation: 10,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(data["name"]),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            20.0),
                                        child:
                                        LinearProgressIndicator(
                                          minHeight: 10,
                                          value: data['saved'] /
                                              data["amount"],
                                          semanticsLabel:
                                          'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Text(
                                        "${date.difference(DateTime.now()).inDays} days left !")
                                  ],
                                ),
                                Text(
                                    "${data["amount"] - data["saved"]} taka left")
                              ],
                            )));
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    ],),);
  }
}
