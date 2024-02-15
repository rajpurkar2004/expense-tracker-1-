import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _budgetStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/budget/').snapshots();

    return Scaffold(appBar: AppBar(title: Text("Budget"),),

    body: Column(children: [
      Flexible(child:  Container(

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
      ) )
    ],),
    );
  }
}
