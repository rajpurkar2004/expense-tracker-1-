
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../function/firebase.dart';
import '../laon_screen/give loan.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersDepth = FirebaseFirestore.instance.collection('main').doc(FirebaseAuth.instance.currentUser!.uid).collection("depth").snapshots();
    final Stream<QuerySnapshot> _usersLoans = FirebaseFirestore.instance.collection('main').doc(FirebaseAuth.instance.currentUser!.uid).collection("loans").snapshots();
    return Scaffold(body:

    ListView(children: [
      Card(

        child: Container(
          color: Colors.indigoAccent,
          child: Column(
            children: [
              Row(children: [
                Icon(Icons.handshake_sharp),
                Text("Give loans "),
              ],),


              Container(height: 150,
                child: Text(""),
              ),
              Divider(),

              TextButton(onPressed: (){


                  Navigator.push(context, MaterialPageRoute(builder: (context) => GiveLoanScreen(),));
                  }, child: Text("Give loan 🤝"))

            ],
          ),
          height: 250,
        ),
      ),


    Text("My Depth",style: TextStyle(fontSize: 24),),


    Flexible(
      child: StreamBuilder<QuerySnapshot>(
      stream: _usersDepth,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
      return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
      return Text("Loading");
      }
      // if (snapshot.hasData) {
      //   return Text("Document does not exist");
      // }

      return Container(
        height: 200,
        child: ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Card(
          color: Colors.orangeAccent,
          child: ListTile(
          title: Text("Sender:${data['senderName']}"),
          subtitle: Text("Sender:${data['senderEmail']}"),
          trailing: Text("${data['loanamount']} ৳"),
          ),
        );
        }).toList(),
        ),
      );
      },
      ),
    ),


      Text("My Loans",style: TextStyle(fontSize: 24),),

      Flexible(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersLoans,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            // if (snapshot.hasData) {
            //   return Text("Document does not exist");
            // }

            return Container(
              height: 200,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Card(
                    color: Colors.orangeAccent,
                    child: ListTile(
                      title: Text("Sent To:${data['sentto']}"),
                      subtitle: Text("Phone Number:${data['phoneNumber']}"),
                      trailing: Text("${data['loanAmount']} ৳"),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),

    ],)
      ,);
  }
}
