import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/FirebaseAuth.dart';

class UpdateGoal extends StatefulWidget {
  const UpdateGoal({Key? key, required this.docid, required this.previous}) : super(key: key);

  final String docid;
 final double previous;

  @override
  State<UpdateGoal> createState() => _UpdateGoalState();
}

class _UpdateGoalState extends State<UpdateGoal> {

  var amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Update Goals"),
    ),
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'saved',
            ),
          ),
        ),

        ElevatedButton(onPressed: (){

          docref.collection("goals")
              .doc('${widget.docid}')
              .update({'saved': widget.previous+double.parse(amountController.text)})
              .then((value) => print("User Updated"))
              .catchError((error) => print("Failed to update user: $error"));


          Navigator.pop(context);

        }, child: Text("Save"))
      ],),
    );
  }
}
