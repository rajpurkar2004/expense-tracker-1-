import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/screen/transaction_screens/filter_screen.dart';
import 'package:expensetrackerapp/screen/transaction_screens/updateExpense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/user.dart';
import '../../widget/expense_card.dart';

class OnlyIncome extends StatefulWidget {
  const OnlyIncome({Key? key}) : super(key: key);

  @override
  State<OnlyIncome> createState() => _OnlyIncomeState();
}

class _OnlyIncomeState extends State<OnlyIncome> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(appBar: AppBar(title: Text("Only Income"),),
    body: Column(children: [
   ElevatedButton(onPressed: (){
     Navigator.push(context,MaterialPageRoute(builder: (context) => FilterScreen())).then((value) { setState(() {});});
   } , child: Text("🎚️ Filter")),

      Flexible(
        child: Container(

          child: StreamBuilder<QuerySnapshot>(
            stream:Provider.of<MyUser>(context, listen: false).expesne,

    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  print(data.length);
                  return data["income"]>0? GestureDetector(
                      onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateExpense(docid:document.id),)) ,

                      child: ExpenseCard(title: data["title"],subtitle: data["description"],amount:data["income"].toString(),date: data["datetime"],icondata: data["category"],)):Text("");
                }).toList(),
              );

            },
          ),
        ),
      ),


    ],)
    );
  }
}
