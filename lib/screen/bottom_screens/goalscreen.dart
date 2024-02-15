import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/screen/goalsScreen/update_goal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/FirebaseAuth.dart';
import '../budget_screen/add_budget_screen.dart';
import '../goalsScreen/goal_detail_screen.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _goalStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/goals/').snapshots();
    final Stream<QuerySnapshot> _budgetStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/budget/').snapshots();
    return Scaffold(
      body: ListView(
        children: [



          Card(
            color: Colors.indigoAccent,
            shape:
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 350,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.sports_soccer),
                        Text(
                          "Goals!",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: 180,
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
                  Divider(
                    thickness: 2,
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalInsideScreen(),
                          )),
                      child: Text(
                        "Create Goal",
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      )),
                ],
              ),
            ),
          ),







SizedBox(height: 50,),









          Card(
            color: Colors.indigoAccent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 350,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on_rounded),
                        Text(
                          "Budgets!",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: 180,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _budgetStream,
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
                          return Center(child: Text("No Budget"));
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

                              return Card(
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  leading: Icon(Icons.monetization_on),
                                  title: Text(data["name"]),
                                  subtitle: Text("Sepending limit ${data["budget"]}"),
                                  trailing: Text("${date.month}"),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBudget(),
                          )),
                      child: Text(
                        "Create Budget",

                        style: TextStyle(fontSize: 20,color: Colors.black),
                      )),
                ],
              ),
            ),
          ),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
