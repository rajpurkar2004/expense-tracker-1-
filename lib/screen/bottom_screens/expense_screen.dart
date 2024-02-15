import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/screen/transaction_screens/transaction_screen.dart';
import 'package:expensetrackerapp/screen/transaction_screens/updateExpense.dart';
import 'package:expensetrackerapp/widget/expense_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/user.dart';
import '../../model/FirebaseAuth.dart';
import '../../widget/corsel_card.dart';
import '../../widget/corselslider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}
class _ExpenseScreenState extends State<ExpenseScreen> {

  @override


  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/')
      .snapshots();

  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(),
      body: Column(
        children: [



       
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("main").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions")
                  .snapshots(),
              builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var ds =  snapshot.data!.docs;
                double income = 0.0;
                double expense=0.0;
                for(int i=0; i<ds.length;i++)
                {
                  income+=(ds[i]['income']).toDouble();
                  expense+=(ds[i]['expense']).toDouble();
                }

                return CorselSlider(income: income, expense: expense, remaining: income-expense,);

              }),

          Expanded(
            child: Container(


              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if(!snapshot.hasData){
                    return Text("No data");
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                      return GestureDetector(
                          onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateExpense(docid:document.id),)) ,
                          onLongPress: (){deleteDoc(document.id);},
                          child: ExpenseCard(title: data["title"],subtitle: data["description"],amount: data["expense"]==0?"+${data["income"].toString()}":"-${data["expense"].toString()}",date: data["datetime"],icondata: data["category"],));
                    }).toList(),
                  );

                },
              ),
            ),
          ),
        ],
      ),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.add),

      onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(context )=>TransactionScreen())),),
    );
  }
}
//