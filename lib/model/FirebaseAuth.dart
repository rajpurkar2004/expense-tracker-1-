
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/model/transaction.dart';
import 'package:expensetrackerapp/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../function/data.dart';
import '../screen/bottom_screens/expense_screen.dart';

var db=FirebaseFirestore.instance;
var authId=FirebaseAuth.instance.currentUser?.uid;
final docRef = db
    .collection("main/$authId/transactions/");


final docref = db
    .collection("main").doc(authId);
void signIn(String email,String password,BuildContext ctx) async{
  final _auth=FirebaseAuth.instance;
  UserCredential authResult;
  try{
    authResult= await _auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }

  catch(exp){
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content:Text(exp.toString())));
  }

}




void signUp(String name,String email,String password,BuildContext ctx,String nidUrl) async{
  final _auth=FirebaseAuth.instance;
  UserCredential authResult;
  try{
    authResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseFirestore.instance.collection("User")
        .doc(authResult.user!.uid)
        .set({
      "user name":name,
      "email":email,
      'nid':nidUrl
    });
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
  catch(exp){
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content:Text(exp.toString())));
  }
}



void forgetpasss(String email)async{
  var _auth=FirebaseAuth.instance;
  await _auth.sendPasswordResetEmail(email: email);
}




//Function for sign out
void signOut()async{
  FirebaseAuth.instance.signOut();
}


//Function for adding transaction
void addTransaction(String title,String category,String description,DateTime dateTime,double expense,double income)async{


  final transaction = TransactionModel(
      title:title,
category:category ,
    expense:expense ,
    income: income,
    description: description,
    datetime: Timestamp.fromDate(dateTime)
  );

  docRef.withConverter(
    fromFirestore: TransactionModel.fromFirestore,
    toFirestore: (TransactionModel transaction, options) => transaction.toFirestore(),
  ).add(transaction);

}


void update(String docid,String title,String category,String description,DateTime dateTime,double expense,double income)async{


  var authId=FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('main/$authId/transactions/');

    users.doc(docid)
      .set({
      "title":title,
      "category":category,
      "expense":expense,
      "income":income,
      "description": description,
      "datetime": dateTime
  });

}
void deletegoal(String docid)async{


  var authId=FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('main/$authId/goals/');

  users.doc(docid).delete();

}

void deleteDoc(String docid)async{


  var authId=FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('main/$authId/transactions/');

  users.doc(docid).delete();

}
var cuUser=FirebaseAuth.instance;
num total=0;
var cart=FirebaseFirestore.instance.collection('users/${cuUser.currentUser?.uid}/transactions');


// getTotal() async {
//   total=0;
//   cart.get().then(
//         (querySnapshot) {
//       querySnapshot.docs.forEach((result) {
//
//
//         total = total + result.data()['income'];
//       });
//     },
//   );
//   toatals.add(total);
// }